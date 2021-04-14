#Pruebas sajtas para identificar los determinantes de las RIN

rm(list=ls()) #Quita todo del espacio de trabajo

# 1° Cargar los paquetes necesarios para correr VAR, o instalarlos

#install.packages("urca")
#install.packages("vars")
#install.packages("mFilter")
#install.packages("tseries")
#install.packages("Rtools")
#install.packages("forecast")
#install.packages("tidyverse")
#install.packages("TSstudio")
#install.packages("ggplot2")

library("urca")
library("vars")
library("mFilter")
library("tseries")
library("Rtools")
library("forecast")
library("tidyverse")
library("TSstudio")
library("ggplot2")

# 2° Luego viene el cargadero de la base datos

library(readxl)
base_rin <- read_excel("R/r_sajtas/base_rin.xlsx")
data_copy <- base_rin # Esta copia es por sia caso
names_rin <- names(base_rin) #Esto para ver cualquier cacho los nombres

#Unos grafiquitos

# ggplot("base_rin") #esto todavía no, vamos a jugar luego

# 3° Estructurar los datos como serie de tiempo

View(base_rin)
rin <- ts(base_rin$rin, start = c(2001,1), frequency = 4)
tcr <- ts(base_rin$tcr, start = c(2001,1), frequency = 4)
i_fed <- ts(base_rin$i_fed, start = c(2001,1), frequency = 4)
i_lac <- ts(base_rin$i_latam, start = c(2001,1), frequency = 4)
i_dif <- i_lac - i_fed
ti <- ts(base_rin$TI, start = c(2001,1), frequency = 4)
pib_ex <- ts(base_rin$IPibE, start = c(2001,1), frequency = 4)
drin <- ts(base_rin$d_rin, start = c(2001,1), frequency = 4)

#aqui unos gráficos simios, solo pa chekear

autoplot(cbind(tcr,ti, pib_ex))
#gra1 <- ggplot(base_rin,aes(time,drin)) + geom_line(colorspaces) # este hay q arreglar

#le voy a poner más gráficos luego, todavía no se como escalar

#ahora unas regresiones de sandeces para ver relación lineal no mas

MCO1 <- lm(drin ~ log(ti))
MCO2 <- lm(drin ~ log(tcr))
MCO3 <- lm(drin ~ pib_ex)

summary(MCO1)
summary(MCO2)
summary(MCO3) #en estos modelos se ve que los signos son los esperados, luego son basura

# 4° Revisión de persistencia (FAC y FACP)

acf(rin, main = "autocorrelación de las RIN")
acf(drin, main = "autocorrelación del flujo de RIN")

pacf(rin, main =  "autocorrelación parcial de las RIN")
pacf(drin, main = "autocorrelación parcial del flujo de RIN")

acf(ti, main = "autocorrelación de los términos de intercambio")
pacf(ti, main = "autocorrelación parcial de los términos de intercambio")

acf(i_dif, main = "autocorrelación del diferencial del rendimiento financiero")
pacf(i_dif, main = "autocorrelación parcial del diferencial del rendimiento financiero")

acf(pib_ex, main = "autocorrelación del PIB externo relevante")
pacf(pib_ex, main = "autocorrelación parcial del PIB externo relevante")

acf(tcr, main = "autocorrelación del Tipo de cambio real")
pacf(tcr, main = "autocorrelación parcial del Tipo de cambio real")

#Ahora hay que hacer tests ADF, por si alguna variable no está 
# cabalmente apropiada en el modelo, o sea si todas tienen RU y alguna no

#pendiente

#Armar el VAR, primero se las agrupa a las variables

rin.1 <- cbind(drin,tcr,i_dif,pib_ex)
colnames(rin.1) <- cbind("Flujo de RIN", "Tipo de cambio real", "Diferencial del rendimiento financiero","PIB externo")

#Una vez agrupadas las variables, se prueba cuántos rezagos quedan mejor para que no se tripee Baneguín

lagselect <- VARselect(rin.1, lag.max = 10, type = "const")
lagselect$selection # Esto ahorita sugiere 9 rezagos, es demasiado así que se opta por 2 de acuerdo a HQ

#podría armarse otro con 9 pero veremos eso más adelante

# Ahora se hace la estimación del VAR inicial

RIN.var <- VAR("rin.1",p = 2, type = "constant")


