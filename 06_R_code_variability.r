# R code variability

library(raster) # Carico i pacchetti
library(RStoolbox) # per la visione delle immagini e il calcolo della variabilità
library(ggplot2) # per i plot con ggplot
library(patchwork) # multiframe con grafici di ggplot2
library(viridis)

setwd("C:/lab") # setto la cartella di lavoro

# Esercizio: importa l'immagine del Similaun
sen <- brick("sentinel.png")

# Esercizio: plotta l'immagine tramite la funzione "ggRGB"
ggRGB(sen, 1, 2, 3, stretch="lin") # lo stretch viene fatto automaticamente, posso ometterlo
# o:
ggRGB(sen, 1, 2, 3)

# Inserisco NIR sulla componente green
ggRGB(sen, 2, 1, 3) # visualizzo bene roccia viola, neve bianca, e vegetazione verde

# Esercizio: plotto i due grafici uno affianco all'altro
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)

# Tramite patchwork:
g1+g2 

# Calcolo dela variabilità sul NIR
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # Utilizzo "focal" (funzione che si basa sulla deviazione standard) con una finestra di 3x3 pixels

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(sd3, col=clsd)

# plotto con ggplot
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer))

# con viridis
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis")

# con cividis
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# con magma
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Esercizio: faccio lo stesso calcolo con una finestra 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)

# Plotto l'immagine della variabilità utilizzando la nuova scala colori
plot(sd7, col=clsd)
dev.off()
