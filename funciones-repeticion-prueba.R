##### Repetir cosas en R como aborígen #######

#### Con funciones vectorizado ####

est_mas = function(volume){
  mass = 2.65*volume^0.9
  return(mass)
}

volumes <- c(1.66, 5.87, 5,99)

est_mas(volumes)

# Ejemplo cons trings indios:

library(stringr)

taras <- c("negro", "sullu", "chino")
raza <- c("choro", "metemano", "chancho")

aclarar_raza_taras <- function(taras, raza){
  taras_mayus <- str_to_sentence(taras)
  taras_raza <- paste(taras_mayus, raza)
  return(taras_raza)
}

# esto tb funciona con columnas de dataframes

dataps <- data.frame(taras,raza)
aclarar_raza_taras(dataps$taras, dataps$raza)

# y sale lo mismo.

#### Usando el apply y derivados ####

# Si se le pone un "if" debajo ya no da pq solo evalua
# al primer valor del vector

est_mas = function(volume){
  if (volume > 5){
    mass = 2.65*volume^0.9  
  } else {
    mass <- NA
  }
  return(mass)
}

volumes <- c(1.66, 5.87, 5.99)

est_mas(volumes) # Sale ese error, no aplica a todo

sapply(volumes, est_mas) # asi sale cache

# lo que hace aqui el saply (simple apply) es:

c(est_mas(volumes[1]), est_mas(volumes[2]), est_mas(volumes[3]))

# e sea, devuelve un vector, con lapply es "lista" y 
# devuelve una lista

lapply(volumes, est_mas) # es lista ps

#### el mapply, cuando hay varios argumentos #####

est_mas = function(volume, veg_type){
  if (veg_type == "tree"){
    mass = 2.65 * volume^0.9
    } else {                   
    mass = NA
  }
  return(mass) # esto más, como de las condicionales
}

volumes <- c(1.66, 5.87, 5.99)
veg_type <- c("shrub", "tree", "tree")

mapply(FUN = est_mas, volume = volumes, veg_type = veg_type)

# en mapply primero va la funciona  emplear y al final
# los datos o el data frame

##### Comibar las funciones propias con dplyr #####

# Algo bueno es que se peuden combinar funciones
# vectorizadas y no vectorizadas y combinarlas

# Partiendo del ejemplo anterior, con algo extra:

library(dplyr)

est_mas = function(volume, veg_type){
  if (veg_type == "tree"){
    mass = 2.65 * volume^0.9
  } else {                   
    mass = NA
  }
  return(mass) # esto más, como de las condicionales
}

#esta funcion ahora:

est_mass_vectorized <- function(volume){
  mass = 2.65 * volume^0.9
  return(mass)
}
volumes <- c(1.66, 5.87, 5.99)
veg_type <- c("shrub", "tree", "tree")

# se debe crear un dataframe para usar el dplyr

plant_data <- data.frame(volumes, veg_type)

plant_data %>%
  mutate(masses = est_mass_vectorized(volumes))

# pero ojo que si se hace así con una función no 
# vectorizada no funciona, más claro si la función 
# tiene una condición:

plant_data %>%
  mutate(masses = est_mas(volumes, veg_type))

# da este error: Problem with `mutate()` column `masses`.
# i `masses = est_mas(volumes, veg_type)`.

# Para solucionar esto y si se quiere abolir este
# problema, se le aumenta "por filas":

plant_data %>%
  rowwise() %>% # hace correr la siguiente fila, fila x fila
  mutate(masses2 = est_mas(volumes, veg_type))

# este ya jala bien.

##### Funciones con otras funciones y dplyr ####

# Con la de arriba:

get_biomass <- function(volumes){
  masses <- est_mass_vectorized(volumes)
  biomass <- sum(masses)
  return(biomass)
}

get_biomass(volumes)

# Ahora con dplyr, se puee aplicar la función por grupos:

plant_data %>%
  group_by(veg_type) %>%
  summarize(biomass = get_biomass(volumes))

# la clave para usar esto es que utiliza una columna
# para producir un único valor 1x1, mientras que lo
# vectorizado te devuelve un vector ps

