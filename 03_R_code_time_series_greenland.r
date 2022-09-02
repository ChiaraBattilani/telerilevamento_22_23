# Time series analysis of Greenland LST data

# Carico e installo i pacchetti da utilizzare
library(raster)

setwd("C:/lab/Greenland") # setto la cartella di lavoro su Windows

# Importo l'immagine
lst2000 <- raster("lst_2000.tif")
lst2000

# Esercizio: importa tutte le immagini
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# Esercizio: crea un multiframe con tutte le immagini cambiando la scala di colori
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)

# Importa tutto le immagini contemporaneamente
rlist <- list.files(pattern="lst") # creo la lista
rlist # Visualizzo i parametri
import <- lapply(rlist, raster) # importo tutto assieme
import # Visualizzo i parametri

tgr <- stack(import) # crea un unico file con i 4 layer
tgr # Visualizzo i parametri

plot(tgr, col=cl) # plot di tutte e 4 le immagini
plot(tgr[[1]], col=cl) # plot del 1° elemento

plotRGB(tgr, r=1, g=2, b=3, stretch="lin") # sovrapposizione temporale

######################################################
### Example 2: NO2 decrease during the lockdown period
######################################################

# Carico e installo i pacchetti da utilizzare
library(raster)
setwd("C:/lab/EN") # setto la cartella di lavoro su Windows

# Importo il primo layer
en01 <- raster("EN_0001.png")

cl <- colorRampPalette(c('red','orange','yellow'))(100) # cambio la scala di colori
plot(en01, col=cl)


# Importo il layer
en13 <- raster("EN_0013.png") 
plot(en13, col=cl)

# Importo tutti i layer assieme

# Esercizio: importo tutto assieme come nell'esempio Greenland con i seguenti passaggi:
# list.files, lapply, stack

rlist <- list.files(pattern="EN") # creo la lista
rimp <- lapply(rlist, raster) # applico alla lista la funzione raster
en <- stack(rimp) # crea un unico file con i 13 layer

plot(en, col=cl) # plotto tutto assieme

# Esercizio: plotta EN01 affianco a EN13
par(mfrow=c(1,2)) # modo 1 con multiframe
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)

# o:
en113 <- stack(en[[1]], en[[13]]) # modo 2 con stack
plot(en113, col=cl)

# facciamo la differenza:
difen <- en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)

# plotRGB dei tre file assieme
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")

sessionInfo() #dà info sula sessione di R
Sys.time() #dà info sulla data e ora attuale
