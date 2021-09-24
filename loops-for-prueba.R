####### Costurando con loops for #######

# la idea básica es:

for (item in lista_de_items){
  hacer_algo(item)
}

# ejemplo con coso:

volumes <- c(1.6, 3, 8)
for (volume in volumes){    # le asigna el nombre "volume" a cada item de la lista existente "volumes"
  mass <- 2.65 * volume^0.9 # hace aparecer mass q no está en el ambiente global
  print(mass)               # se le pide imprimir explicitamente pq sino no lo hace, igual que las funciones
}

# se le pueden poner mas cosas:

for (volume in volumes){    
  mass <- 2.65 * volume^0.9
  mass_lb <- mass*2.2 # esto por ovejo
  print(mass_lb)      
}

##### usando loops para repetir por índice ####

# la idea es, en lugar de trabajar sobre valores directamente, los cuales no se almacenan,
# hacer la corrida y guardar los resultados para trabajarlos despues, o en un siguiente paso.

# ejemplo:

volumes <- c(1.6, 3, 8)
masses <- vector(length = length(volumes), mode = "numeric") # la primera diferencia es que se debe crear donde guardar
for (i in 1:length(volumes)){    # "i" es de "index" y señala del 1 hasta cuando hará la repetición
  mass <- 2.65 * volumes[i]^0.9  # aqui hace el subset del i_ésimo elemento del índice a operar
  masses[i] <- mass            # en lugar de imprimir como paria, se guardan los resultados
}

# Luego es recomendable hacer el debug para ver si las cosas se estan guardando donde deben.

##### loop en varios objetos a la vez ######

# se puede hacer lo mismo que antes pero los parámetros pueden ser otros vectores:
# hay que crear los vectores con los parámetros apra poner el ejemplo bien:

volumes <- c(1.6, 3, 8)
b0 <- c(2.65, 1.28, 3.29)
b1 <- c(0.9, 1.1, 1.2)
masses <- vector(length = length(volumes), mode = "numeric") # la primera diferencia es que se debe crear donde guardar
for (i in 1:length(volumes)){      # "i" es de "index" y señala del 1 hasta cuando hará la repetición
  mass <- b0[i] * volumes[i]^b1[i] # aqui hace el subset del i_ésimo elemento del índice a operar de los vectores b0 y b1
  masses[i] <- mass              # en lugar de imprimir como paria, se guardan los resultados
}