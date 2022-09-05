# Codice R per calcolare lavariabilità spaziale basata su mappe multivariate

library(raster) # carico i pacchetti
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

setwd("C:/lab") # setto la cartella di lavoro su Windows

siml <- brick("sentinel.png") # importo l'img

# NIR 1
# red
# green

# Uso "ggRGB" perchè è un'immagine RGB e non faccio lo stretch, lo fa da sè
ggRGB(siml, 1, 2, 3) # suolo nudo è verde
ggRGB(siml, 3, 1, 2) # metto NIR al posto di green; suolo nudo viola, acqua scura

# Eserczio: calcolare un PCA sull'immagine
simlpca <- rasterPCA(siml)

# $call
# $model
# $map

# Esercizio: osserva quanta varianza è spiegata da ciascuno
summary(simlpca$model)

# Plotto la PCA
plot(simlpca$map)

# Creo dei plot con "ggplot" aggiungendo "geom_raster", "scale_fill_viridis" e il titolo
g1 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g3 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC3)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC3")

g1+g3

# Esercizio: inserisci la seconda componente nel grafico

g2 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC2)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC2")

g1+g2+g3

# Calcolare la variabilità per PC1

pc1 <- simlpca$map[[1]]

sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) # Utilizzo la funzione "focal" con una finestra 3x3
# posso farne altri varando la finestra, ad esempio 5x5 o 7x7

ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation of PC1")
