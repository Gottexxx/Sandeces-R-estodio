##### Funciones y loops #####

# Partiendo de la función simplecita no vectorizada

est_mas = function(volume){
  if (volume > 5){
    mass = 2.65 * volume ^ 0.9  
  } else {
    mass <- NA
  }
  return(mass)
}

volumes <- c(1.66, 3, 7.99)

# Ahora es loopear por índice para guardar los resultados

masses <- vector(mode = "numeric", length = length(volumes))

# ahora el loop

for (i in 1:length(volumes)){
  mass <- est_mas(volumes[i]) # el cálculo principal la hace la función apra cada valor del índice
  masses[i] <- mass
}

# esta es la operativa de la función apply() del base o sapply

masses_apply <- sapply(volumes, est_mas)