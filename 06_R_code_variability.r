# R code variability

library(raster)
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork)
library(viridis)

setwd("C:/lab")

# Exercise: import the Similaun image
sen <- brick("sentinel.png")

# Exercise: plot the image by the ggRGB function
ggRGB(sen, 1, 2, 3, stretch="lin") # stretch is done a
# hence:
ggRGB(sen, 1, 2, 3)

# NIR on green component
ggRGB(sen, 2, 1, 3) # visualizzo bene roccia viola, neve bianca, e vegetazione verde

# Exercise: plot the two graphs one beside the other
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)

# Thanks to patchwork!:
g1+g2 

# calculation of variability over NIR
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(sd3, col=clsd)

# plotting with ggplot
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer))

# with viridis
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis")

# cividis
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# magma
ggplot() +
geom_raster(sd3, mapping = aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Exercise: make the same calculation with a 7x7 window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)



















