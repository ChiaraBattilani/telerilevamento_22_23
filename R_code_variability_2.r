# R code for calculating spatial variability based on multivariate maps

library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)

setwd("C:/lab")

siml <- brick("sentinel.png") # importo l'img

# NIR 1
# red
# green

ggRGB(siml, 1, 2, 3) # suolo nudo è verde
ggRGB(siml, 3, 1, 2) # suolo nudo viola, acqua scura

# Exercise: calculate a PCA on the image
simlpca <- rasterPCA(siml)

# $call
# $model
# $map

# Exercise: view how much variance is explained by each
summary(simlpca$model)

g1 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g3 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC3)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC3")

g1+g3

# Exercise: inserti the second component in the graph

g2 <- ggplot() +
geom_raster(simlpca$map, mapping=aes(x=x, y=y, fill=PC2)) +
scale_fill_viridis(option = "inferno") +
ggtitle("PC2")

g1+g2+g3

# let's calculate variability

pc1 <- simlpca$map[[1]]

sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)

ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation of PC1")



























