##################################################################################
# Ahora los primeros pasos en el manejo de strings caraja#########################
##################################################################################

supressMessages(supressWarnings(library(dplyr)))        # Wrangling: mutate().
supressMessages(supressWarnings(library(stringi)))      # Operador para concatenar strings %s+%
supressMessages(supressWarnings(library(stringr)))      # Manipulación de strings del tidyverse
supressMessages(supressWarnings(library(glue)))         # formatear strings
supressMessages(supressWarnings(library(magrittr)))     # los pipes para procesar data %>% %>T% %<>%
supressMessages(supressWarnings(library(rattle.data)))  # data clima
supressMessages(supressWarnings(library(scales)))       # commas(), percent ()

