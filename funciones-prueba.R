#### ejemplos de crear funciones ####

nombre_funcion <- function(inputs) {
  valor_salida <- hacer_algo(inputs)
  return(valor_salida)
}

calc_arbs_vol <- function(largo = 1, ancho = 2, altura = 3){
  area <- largo * ancho
  volumen <- area * altura
  return(volumen)
}

# se le puede poner valores por defecto con el "=", para q
# luego no sea necesario poner en el orden exacto. Ponerle,
# todos los argumentos hace q no sea necesario acordarse
# el orden.

# Para probar la combinacion, hacemos otra función:

est_arbs_mass <- function(volumen){
  mass <- 2.65 * volumen^0.9
  return(mass)
}

# ejemplo de combinar las dos

vol_arbs <- calc_arbs_vol(2,4)
mass_arbs <- est_arbs_mass(vol_arbs)

# ahora con pipes, lo mismo es pero ojo en el orden

library(dplyr)

mass_arbs <- calc_arbs_vol(2,4) %>%
  est_arbs_mass()

# anidado tb se puede pero es poco legible

mass_arbs <- est_arbs_mass(calc_arbs_vol(2,4))

# se puede hacer todo de una con una funcion con
# funciones adentro:

est_arbs_mass_dim <- function(largo = 1, ancho = 2, altura = 3){
  volumen <- calc_arbs_vol(largo = 1, ancho = 2, altura = 3)
  mass_arbs <- est_arbs_mass(volumen)
  return(mass_arbs)
}

## Nota: nunca se asume que las operaciones dentro de las
## funciones estan disponibles en el global envorinoment,
## pero las funciones del global siempre estan disponibles
## para hacer operaciones con funciones, asi adentro.