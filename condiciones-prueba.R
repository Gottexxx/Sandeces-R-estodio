#### Condicionales remberth #####

# El %in% se utiliza como parece, y devuelve un T o F

#### usando el if ####

# Es importante entender que el if se ejecuta con {}
# pero no es una función, y trabaja con los elementos
# disponibles en el global environment y devuelve
# elementos que también estarán disponibles en el
# mismo.

x = 4        # se le asigna valor
if (x < 5) { # se establece la condición
  x = x*5000 # Lo que pasa entre llaves si se cumple
}            # fin

# Si no se cumple, digamos así:

y = 4        # se le asigna valor
if (y > 5) { # se establece la condición
  y = y*5000 # Lo que pasa entre llaves si se cumple
}            #fin, sigue igual pq no cumplía

#### utilizando tb el else ####

# Algo puede pasar cuando no se cumple la condición

# ejemplo con vegetales taras

veg_type = "shrub" # se establecen las condiciones
volume = 16.08     
if (veg_type == "tree"){
  mass = 2.65 * volume^0.9 #Si se cumple, se ejecuta
} else if (veg_type == "shrub"){ # else if, pa probar
  mass = 0.65 * volume^1.2  # otra condicion
} else {                   # si nada se cumple, este
  mass = NA
}

# Desde el primer "if", solo se cumplirá la parte
# del código entre {} que cumpla la condición, 
# todo lo demás del bloque quedará sin utilizar.

##### Poniéndole dentro de funciones #####

# se usa como inputs en la función en lugar de que
# esten ahi afuera oseando las variables

est_mas = function(volume, veg_type){
  if (veg_type == "tree"){
    mass = 2.65 * volume^0.9
  } else if (veg_type == "shrub"){ 
    mass = 0.65 * volume^1.2  
  } else {                   
    mass = NA
  }
  return(mass) # se copia lo de arriba, pero esto más
} # pq el function va casado con el return

est_mas(1.4, "tree") # ejemplo

# También se pueden meter condicionaes de los
# condicionales, con la misma función anterior

est_mas = function(volume, veg_type, age){ #aqui age
  if (veg_type == "tree"){
    if (age < 5) {
      mass = 1.6 * volume^0.8
    } else {
      mass = 2.65 * volume^0.9 # esto se cortó y subió
      }
    } else if (veg_type == "shrub"){ 
    mass = 0.65 * volume^1.2  
  } else {                   
    mass = NA
  }
  return(mass)
} # y claro hay q re - correr/definir la función


