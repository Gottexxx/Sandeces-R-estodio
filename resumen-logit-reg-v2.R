
##### Carga de librerias sajtas #####

library(tidyverse)
library(tidytext)
library(udpipe)
library(gutenbergr)
library(rsample)
library(glmnet)
library(yardstick)

##### 1. Cargar los libros del gutenberg ####

twist_tale <- gutenberg_metadata %>%
  filter(
    title %in% c("A Tale of Two Cities", "Oliver Twist"),
    has_text,
    language == "en") %>%
  pull(gutenberg_id) %>%
  gutenberg_download(meta_fields = "title")

##### 2. Quitarle los blancos #####

twist_tale <- twist_tale %>%
  filter(text != "")

View(twist_tale)

##### 3. Crear la varialbe lógica ######

twist_tale <- twist_tale %>%
  mutate(
    es_two_cities = case_when(
      title == "A Tale of Two Cities" ~ 1L,
      title == "Oliver Twist" ~ 0L
    ),
    line_id = row_number()
  )%>%
  view()

##### 3.1. Guardar los resultados y contar las filas ####

twist_tale %>%
  count(title)

##### 4. Preparar el dataset y modelar #####

dl <- udpipe_download_model(language = "english")
english_model <- udpipe_load_model(dl$file_model)

text <- twist_tale %>%
  select(doc_id = line_id, text)

twist_tale_preprocesado <- udpipe(text, english_model, parallel.cores = 4L)

##### 4b. crear un algoritmo de entrenamiento #####

set.seed(1234L)
twist_tale_split <- initial_split(twist_tale)
twist_tale_training <- training(twist_tale_split)
twist_tale_testing <- testing(twist_tale_split)

##### 4a. Ponerlo en minúsculas y quitarle la mugre ####

sparse_train_data <- twist_tale_preprocesado %>%
  mutate(lemma = str_to_lower(lemma)) %>%
  anti_join(stop_words, by = c("lemma" = "word")) %>%
  filter(upos %in% c("PUNCT", "SYM", "X", "NUM")) %>%
  mutate(doc_id = as.integer(doc_id)) %>%
  anti_join(twist_tale_testing, by = c("doc_id" = "line_id")) %>%
  count(doc_id, lemma) %>%
  cast_sparse(doc_id, lemma, n)



##### 5a. Crear matriz documental #####



##### 5b. Excluir los resultados irrelevantes y guardarlos ####

y <- twist_tale_training %>%
  filter(line_id %in% rownames(sparse_train_data)) %>%
  pull(es_two_cities)

##### 6a. Calcular la regresión logística regularizada ####

model <- cv.glmnet(sparse_train_data, y, family = "binomial", 
                   keep = T, trace.it=1)

coeficientes <- model$glmnet.fit %>%
  tidy() %>%
  filter(lambda == model$lambda.1se)

coeficientes %>%
  group_by(estimate > 0) %>%
  slice_max(estimate, n = 5) %>%
  ungroup()

coeficientes %>%
  group_by(estimate > 0) %>%
  slice_max(estimate, n = 5) %>%
  ungroup() %>%
  ggplot() +
  geom_col(aes(x = fct_reorder(term, estimate), y = estimate, fill = estimate > 0)) + 
  coord_flip()