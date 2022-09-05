# Codice R per modellare la distribuzione delle specie

# Carico i pacchetti
library(raster) # predictors
library(sdm) 
library(rgdal) # species

# Non usiamo la working directory perchè utilizziamo file da libreria
file <- system.file("external/species.shp", package="sdm") # carica un file da un pacchetto
species <- shapefile(file)

plot(species, pch=19) # pch=19 fa pallini al posto delle crocette

species$Occurrence # valori che indicano punti nello spazio in cui c'è assenza o presenza

# Assegno ad un oggetto le occurence della specie
occ <- species$Occurrence

plot(species[occ == 1,], col="blue", pch=19) # plotto solo quelli con valore pari a 1 ovvero le presenze
points(species[occ == 0,], col="red", pch=19) # così aggungo i punti 0 delle assenze al plot precedente senza cambiare il plot

# Predisctors: prima faccio il percorso della funzione "system files"
path <- system.file("external", package="sdm")

# Lista di predittori
lst <- list.files(path=path, pattern='asc', full.names=T) # full.names is needed in case you want to maintain the whole path in the name of the file

# Faccio uno stack (non serve il brick in quetso caso)
preds <- stack(lst) # non avremo le bande in questo caso, ma elevazione, precipitazione, temperatura e vegetazione

cl <- colorRampPalette(c('blue','orange','red','yellow'))(100) # creo una scala di colori
plot(preds, col=cl)

# Plotto i predittori, dando loro prima un nome
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

plot(elev, col=cl)
points(species[occ == 1,], pch=19) # così non sovrascrivo il plot

plot(prec, col=cl)
points(species[occ == 1,], pch=19)

plot(temp, col=cl)
points(species[occ == 1,], pch=19) 

plot(vege, col=cl) 
points(species[occ == 1,], pch=19)

# facciamo un modello a cui associamo le probabilità più o meno elevate ai dati di T, elev, prec e vege
# Tramite "sdmData" dichiaro i dati
datasdm <- sdmData(train=species, predictors=preds)

# Creo modello tramite la funzione "sdm"
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data= datasdm, methods="glm")

# Faccio una previsione della mappa finale tramite "predict"
p1 <- predict(m1, newdata=preds) # sulla base del modello m1 dove è più prbabile trovare una specie

# Plotto la previsione assieme ai punti della distribuzione
plot(p1, col=cl)
points(species[occ == 1,], pch=19)

par(mfrow=c(2,3))
plot(p1, col=cl)
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)

# alternativa tramite "stack" #2, così ho i titoli
final <- stack(preds, p1)
plot(final, col=cl)
