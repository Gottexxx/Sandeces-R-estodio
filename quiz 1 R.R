# Tarea 1 del coursera
# desde la pregunta 11

rm(list=ls())
data <- read.csv("hw1_data.csv")

#p. 11: In the dataset provided for this Quiz, what are the column names of the dataset?

names(data) # ver nombres
colnames(data) # esto es lo mismo q lo anterior
row.names.data.frame(data) # esto por tara, no sirve en este caso

#p.12: Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

x <- data[1:2,]
x

#p.13: How many observations (i.e. rows) are in this data frame?

rownames(data)

#p.14: Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

y <- data[152:153,]

#p.15: What is the value of Ozone in the 47th row?

data[47,"Ozone"] #asi
data[47,1] # o tb asi

#p.16: How many missing values are in the Ozone column of this data frame?

ozonin <- data[,1] #se genera un vector solo con esa columna
is.na(ozonin) # se ven cuantos NAs hay
ozoNa <- is.na(ozonin) # vector lógico
ozo_ok <- complete.cases(ozonin) # lo mismo pero de otra forma
ozo_ok <- complete.cases(ozonin)
p16 <- ozo_ok[ozo_ok>0]
p16_2 <- ozoNa[ozoNa==0] # aqui solo era de otra forma, la idea es la misma
p16_2 #sale 37 pero contando a lo tara

#p.17:What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

ozo_ok <- complete.cases(ozonin)
mean(ozo_ok) # sale 0.7581699 asi no mas
ozonin[ozo_ok] # asi si sacas los valores del vector numérico
mean(ozonin[ozo_ok]) # sale 42.12931

#p.18: Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90.
# What is the mean of Solar.R in this subset?

#una forma era así pero no sale bien el resultado

data3 <- subset(data, Ozone > 31, select = c(Ozone, Temp, Solar.R))
data3 <- subset(data, Temp > 90, select =  Solar.R)
colMeans(data3) #sale 225

#p.19: What is the mean of "Temp" when "Month" is equal to 6?

data4 <- subset(data, Month == 6, select = Temp)
colMeans(data4) # sale 79,1 q esta ok

#p.20: What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?

data5 <- subset(data, Month == 5, select = Ozone)
data5 # se ve que es 115



