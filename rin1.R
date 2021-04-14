rm(list=ls()) #Removes all items in Environment!
setwd("C:/Users/Indian/Documents/R/r_sajtas")
library(tseries) # for ADF unit root tests
library(dynlm)
library(nlWaldTest) # for the `nlWaldtest()` function
library(lmtest) #for `coeftest()` and `bptest()`.
library(broom) #for `glance(`) and `tidy()`
library(PoEdata) #for PoE4 datasets
library(car) #for `hccm()` robust standard errors
library(sandwich)
library(knitr) #for kable()
library(forecast)
library(vars) # for function `VAR()`
library(readxl) # install.packages("readxl")
base_rin <- read_excel("base_rin.xlsx", col_types = c("text",+"numeric", "numeric", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
data_copy <- base_rin
names_rin <- names(base_rin)
