# R code for multivariate analysis

library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)

setwd("C:/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd") #carico immagine
plot(p224r63_2011)

#ricampionamento: resampling
p224r63_2011res <- aggregate(p224r63_2011, fact=10) # uso aggragate per fare il ricampionamento

g1 <- ggRGB(p224r63_2011, 4,3,2) # img definita con risoluzione 30x30
g2 <- ggRGB(p224r63_2011res, 4,3,2) # img meno definita con risoluzione 300x300

g1+g2

# aggressive resampling
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)
g3 <- ggRGB(p224r63_2011res100, 4,3,2)

g1+g2+g3





