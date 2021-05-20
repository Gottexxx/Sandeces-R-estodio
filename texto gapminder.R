# Este es un experimento tropikondor
# Cargadero de librerias
library(dplyr)    # Costuramiento de datos
library(magrittr) # Pipes dice
library(ggplot2)  # visualizashon del dato
library(gapminder) # La data gigante del sueco loco

# hay la base de datos del tata en el R:

data(gapminder)

# diplicar por si la cagas

gap <- gapminder

rm(gapminder)

#Nombre de las variables
colnames(gap)

#clase de los opjetos
class(gap)

#chekear como son los datos. Sale bonito con el tidyverse
sample_n(tbl = gap, size = 10)

#ver la dimesión
dim(gap)

# nro de registros
gap %>% nrow() -> n 

# estos %>% son los pipes, sirven rico para mineria de texto
# en extracciones mas complejas hay hasta 10 y se lee "y entonces"  y 
# lo que salga a la derecha

# nro de variables
gap %>% ncol() -> p

# nro de registros completos
gap %>%
  complete.cases() %>%
  sum()
#lo que hace esto con el pipe es
#el %>% sin accion es para anidar, como el for o else
# complete cases te da el numero 1 si esta completo, y 0 si no
# y luego dice y entonces, me lo sumas. El resultado deberia ser un número
# Si el número es igual que el tamaño de la muestra, ésta está completa


#se puede hacer lo mismo más "a lo data sayens" propio del R

# clase de variable
sapply(X = gap, FUN = class)

# cuando muestra "factor" es q ese tipo de variable tiene algunas restricciones
# para se trabajada como texto, pero se puede costurar

# y lo mismo pero con pipes:
gap %>% sapply(class)

#resumen de los datos
gap %>% summary()

####################################
# Ahora si para indear con dplyr####
####################################

# seleccionar variables
gapminder %>%
    select(country, year, lifeExp, gdpPercap)

# filtrar un continente específico
gapminder %>%
    filter(continent == "Americas")

# filtrar por país Bolivia
gapminder %>%
    filter(country == "Bolivia")

# filtrar por paises Bolivia o Perú
gapminder %>%
  filter(country == "Bolivia" | country == "Peru")

# filtrando solo los registros de paises de la Alianza del Pacífico
gapminder %>%
    filter(country %in% c("Chile","Colombia", "Mexico", "Peru")) -> gap_ap

view(gap_ap)

# El %in% esta dentro de los pipes y sirve para ver adentro, como una sub base

# Construir una base de datos con las variables 'country', 'year', 'gdpPercap'
# y entonces "%>%", filtrar por paises de la alianza del pacifico y por anhos 
# del siglo XXI

gapminder %>%
  select(country, year, gdpPercap) %>%
  filter(country %in% c("Chile", "Colombia", "Mexico", "Peru") & year >= 2000)

# Lo último pero paso a pasito
gapminder %>%
  select(country, year, pop) %>%
  filter(country %in% c("Chile", "Colombia")) %>%
  filter(year == 2007)

# El select y el filter se usa mucho en mineria de datos
# Ahora una cosa chevere ps para agrupar una base por una variable o factor
# eso si se usa indio para trabajar con texto, el group_by, q es del dlpyr

gapminder %>%
    group_by(continent) %>%
    summarize(n_observaciones = n(), n_paises = n_distinct(country))

# Esto es agrupar por continente y entonces, contar cuantos registros tiene cada continente
# y entonces, contar cuantos paises distintos tiene cada continente (n_distinct)
# tambien se puede agrupar por mas cosas, solo hay q ponerle una coma en el gourp_by

# Construir una base de datos con country, year, gdpPercap
# y entonces, filtrar por pais Bolivia
# y entonces, construir el logaritmo de gdpPercap como nueva variable
gapminder %>%
    select(country, year, gdpPercap) %>%
    filter(country == "Bolivia") %>%
    mutate(log_gdpPercap = log(gdpPercap))

# El mutate es el comando para crear nuevas variables asi sobre la marcha
# si le pones el mismo nombre exacto lo sobre escribe, aunque si no guardas 
# en la base de datos, no pasa nada como en este ejemplo

# ahora otro ejemplo pero con operación
# construir una base de datos con las variables continetnt, lifeExp
# y entonces, agrupar por continente
# y entonces, calcular el promedio de lifeExp
gapminder %>%
  select(continent, lifeExp) %>%
  group_by(continent) %>%
  summarise(prom_lifeExp = mean(lifeExp))

# Ahora maso lo ismo pero en lugar del promedio mínimos y máximos, y se guarda
# construir una base de datos con las variables continetnt, lifeExp
# y entonces, agrupar por continente
# y entonces, calcular el mínimo y máximo de lifeExp
gapminder %>%
  select(continent, lifeExp) %>%
  group_by(continent) %>%
  summarise(min_vida = min(lifeExp), max_vida = max(lifeExp)) -> tab
  
View(tab)

# Aqui como que lo mismo pero partiendo de in filtro
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(lifeExp = median(lifeExp))

# este mas
# construir una base de datos con las variables country, pop
# y entonces, filtrar por paises del mercosur
# y entonces, construir la variable pop en millones
# y entonces, calcular el max de popMill
# Este varia del ejemplo porque no consuderaba a Bolivia che
gapminder %>%
    select(country, pop) %>%
    filter(country %in% c("Argentina", "Brasil", "Paraguay", "Uruguay", 
                          "Venezuela", "Bolivia")) %>%
    mutate(popMill = pop/1000000) %>%
    group_by(country) %>%
    summarise(max_popMill = max(popMill))

# Uno mas pero con el comando arrange que es para ordenar de mayor a menor y asi
# Construir una base de datos con continent, country, year, gdpPercap
# y entonces, filtrar por continente America y año 2007
# y entonces, organizar ascendentemente por gdpPercap
gapminder %>%
    select(continent, country, year, gdpPercap) %>%
    filter(continent == "Americas" & year == 2007) %>%
    arrange(gdpPercap) -> higos2
View(higos2)

##########################################################
## Ahora el ejercicio con la misma base pero para dibujines
##############################################
rm(list=ls()) #Quita todo del espacio de trabajo
# Tb se puede borrar todo el global environment

library(dplyr)    # Costuramiento de datos
library(magrittr) # Pipes dice
library(ggplot2)  # visualizashon del dato
library(gapminder) # La data gigante del sueco loco

# hay la base de datos del tata en el R:

data(gapminder)

# duplicar por si la cagas

gap <- gapminder
rm(gapminder)

# Un boxplot

windows() # Esto solo hace q se haga en una ventana aparte y no en la aprte inferior derecha
ggplot(data = gap, mapping = aes(x = " ", y = gdpPercap))+ # base con la q se trabajará, q
  geom_boxplot()+                                         # se pondrá en el eje x, en el y,
  labs(title = "Distribución PIB per cápita",             # sale feo x si acaso
       x    = " ",
       y    = "PIB per cápita")

# El mismo boxplot pero con otros cositos:
# stat_summary => poner una estadistica sobre un gráfico (Boxplot)
# aplha = transparencia de los puntitos
# outlier_ => opciones para la forma y tamaño

windows()
ggplot(data = gap, mapping = aes(x = " ", y = gdpPercap)) + 
  geom_boxplot(colour = "red", outlier.shape = 16, outlier.size = 1, alpha = 0.25) +
  stat_summary(fun = mean, geom = "point", shape = 4, size = 3, colour = "red") 
  labs(title = "Distribución PIB per cápita",
       subtitle = "Todos los países",
       caption = "Source: Gapminder",
       x    = " ",
       y    = "PIB per cápita")
  
  # igual sale feo x si acaso

data(gapminder)
  gapminder %>%
    filter(country %in% c("Chile","Colombia", "Mexico", "Peru")) -> gap_ap
  
View(gap_ap)

# un boxplot por países con el gap_ap q definimos:
# lo unico q era necesario agregar respecto al anterior era ponerle country
# en el mapeo, pq "x" estaba al aire

windows()
ggplot(data = gap_ap, mapping = aes(x = country, y = gdpPercap))+
  geom_boxplot()

# A este mismo le agregamos cositas
# el geom_jitter (agitador en inglis) es para que los puntitos no estén apiñados

windows()
ggplot(data = gap_ap, mapping = aes(x = country, y = gdpPercap, colour = country))+
  geom_boxplot()+
  geom_jitter(shape = 16, position = position_jitter(0.1), alpha = 0.25)+
  labs(title = "Distribución PIB per cápita",
       subtitle = "Alianza del Pacífico",
       caption = "Source: Gapminder",
       x = "País",
       y = "PIB per cápita",
       color = "País")

# Ahora un Histograma
windows()
ggplot(data = gap, aes(x = gdpPercap))+
  geom_histogram()

# luego se lo decora
# bin => el numero te dice el numero de barritas del histograma

windows()
ggplot(data = gap, aes(x = gdpPercap, y = ..density..))+
  geom_histogram(bins = 30, color = "darkblue", fill = "lightblue") +
  labs(title = "Distribución PIB per cápita",
       subtitle = "Todos los países",
       caption  = "Source: Gapminder",
       x = "PIB per cápita",
       y = "Densidad")

# Un histograma compuesto
# facet_wrap permite la división por alguna categoria, pero es la misma data (faceta esps)
windows()
ggplot(data = gap, aes(x = gdpPercap))+
  geom_histogram() +
  facet_wrap(~continent) +
  labs(title = "Distribución PIB per cápita",
       subtitle = "Todos los países por continente",
       caption  = "Source: Gapminder",
       x = "PIB per cápita",
       y = "Frecuencia")

# un grafiquito de densidad
# al poner deom_density uno hace la estimación de la funcion del kernel de los datos
# el alpha es lo q controla la transparencia del color

windows()
ggplot(data = gap, aes(x = log(gdpPercap), colour = "continent", fill = continent)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~continent) +
  labs(title = "Distribución PIB per cápita",
       subtitle = "Todos los países por continente",
       caption  = "Source: Gapminder",
       x = "PIB per cápita",
       y = "Densidad")

# lo mismo pero sin facetas
windows()
ggplot(data = gap, aes(x = log(gdpPercap), colour = "continent", fill = continent)) +
  geom_density(alpha = 0.5) +
  labs(title = "Distribución PIB per cápita",
       subtitle = "Todos los países por continente",
       caption  = "Source: Gapminder",
       x = "PIB per cápita",
       y = "Densidad")

# Dispersogramas
# uno super simple:
windows()
qplot(x = gap$lifeExp, y = gap$gdpPercap)

# exactamente lo mismo pero con ggplot
windows()
ggplot(data = gap)+
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap))

# a partir de este se puede ir puliendo k.ch:
windows()
ggplot(data = gap)+
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, size = pop), colour = "red") + 
  labs(title = "Pib per cápita vs. Esperanza de vida",
       x = "Esperanza de vida",
       y = "PIB per cápita")

# + k.ch:
# scale_y_con trnas log es ponerlo en escala logaritmica, muy utilizado en econometria
# a menos q seas simio y quieras trabajar con modelo lineal generalizado

windows()
ggplot(data = gap) +
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, size = pop, colour = continent), alpha = 0.25)+
    scale_y_continuous(trans = "log") + 
    labs(title = "Pib per cápita vs. Esperanza de vida",
       subtitle = "Todos los países",
       caption = "Source: Gapminder",
       x = "Esperanza de vida",
       y = "PIB per cápita",
       color = "Continente",
       size = "Población")

