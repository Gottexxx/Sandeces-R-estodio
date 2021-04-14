#Aqui comienza el codigo para leer la base de datos

rm(list=ls()) #Quita todo del espacio de trabajo

#Cargamos los paquetes encesarios para realizar el trabajo

library(haven) # Para importar de spss y stata
library(ggplot2) # Graficos richis
library(tidyr) # Herramientas para manipular mas facil
library(tidyverse) # Complemento
library(lubridate) # Fechas (por si acaso)

#install.packages("RColorBrewer")
library(RColorBrewer) # Por si da para hacer grafiquitos

#Importa la base de datos que esta en spss (.sav)

#Seleccionar directorio de trabajo

setwd("~/R/r_sajtas/Remesas aeropuerto")

X2_ENC <- read_sav("~/R/r_sajtas/Remesas aeropuerto/2_ENC.sav")

#se abre la base

View(X2_ENC)
attach(X2_ENC)

