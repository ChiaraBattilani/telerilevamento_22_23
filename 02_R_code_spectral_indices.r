# Carico e installo pacchetti
library(raster)
library(RStoolbox) # RStoolbox serve per calcolare l'indice di vegetazione
# install.packages("rasterdiv") # rasterdiv serve per calcolare indici di diversità su matrici numeriche
library(rasterdiv)

# Settaggio WD in Windows
setwd("C:/lab")

# Esercizio: importa il primo file defor1_.jpg e dagli il nome l1992
l1992 <- brick("defor1_.jpg")

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green

# Esercizio: importa il primo file defor2_.jpg e dagli il nome l2006
l2006 <- brick("defor2_.jpg")

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Esercizio: plot in un multiframe le due immagini una sopra all'altra
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index 1992
# Potevo usare anche assegnazione <-
dvi1992 = l1992[[1]] - l1992[[2]] # uso elemento
# or:
# dvi1992 = l1992$defor1_.1- l1992$defor1_.2 #uso il nome
dvi1992

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992, col=cl)

# DVI Difference Vegetation Index 2006
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2006, col=cl)

# DVI difference in time
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)
dev.off()
plot(dvi_dif, col=cld)

# Day 2

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

# Quindi l'NDVI può essere usato anche con immagini con risoluzione radiometrica differente

# NDVI 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# or
# ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi1992, col=cl)

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

# NDVI 2006
dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

# Multiframe with NDVI1992 image on top of the NDVI2006
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# Automatic spectral indices by the spectralIndices
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992, col=cl)

si2006 <- spectralIndices(l2006, green=3, red=2, nir=1)
plot(si2006, col=cl)

### rasterdiv
plot(copNDVI)








