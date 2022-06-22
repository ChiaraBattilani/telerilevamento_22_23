# R code for species distribution modelling

library(raster) # predictors
library(sdm) 
library(rgdal) # species

# non usiamo la working directory perchè utilizziamo file da libreria
file <- system.file("external/species.shp", package="sdm") # carica un file da un pacchetto
species <- shapefile(file)

plot(species, pch=19) # pch=19 fa pallini al posto delle crocette

species$Occurrence # valori che indicano punti nello spazio in cui c'è assenza o presenza

occ <- species$Occurrence

plot(species[occ == 1,], col="blue", pch=19) # stampo solo quelli con valore pari a 1 ovvero le presenze
points(species[occ == 0,], col="red", pch=19) # così aggungo i punti 0 delle assenze al plot precedente senza cambiare il plot

# predisctors: prima faccio il percorso della funzione system files
path <- system.file("external", package="sdm")

# list the predictors
lst <- list.files(path=path, pattern='asc', full.names=T)










