##### Haciendo loop para leer varios archivos #####

# se puede hacer la prueba con archivos bajados de por enay

download.file("https://www.datacarpentry.org/semester-biology/data/locations.zip",
              "locations.zip")

# Lo rico es q se baja en el working directory

unzip("locations.zip") # se descomprime desde aqui mismo

data_files <- list.files(pattern = "locations-") # se escoge el patrón en elnombre de los
# archivos. El list files no es nada del otro mundo, hay q ver si se puede combinar 
# con el pdftools

results <- vector(mode = "integer", length = length(data_files)) # aqui se va a guardar

# Ahora es hacer el loop q meta los resultados en el vector vacío. En el ejemplo se va a
# contar el número de filas en el txt, q se puede leer como csv pq está estructurado

for(i in 1:length(data_files)){
  data <- read.csv(data_files[i])
  count <- nrow(data)
  results[i] <- count
}
