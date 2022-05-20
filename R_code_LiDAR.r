# R code for visualising and analysing LiDAR data

library(raster)
library(ggplot2)
library(viridis)
library(RStoolbox)
install.packages("lidR")
library(lidR)

setwd("C:/lab")

# carico i dati del 2013
dsm_2013 <- raster("C:/lab/2013Elevation_DigitalElevationModel-0.5m.tif")
dtm_2013 <- raster("C:/lab/2013Elevation_DigitalTerrainModel-0.5m.tif")

plot(dtm_2013)

chm_2013 <- dsm_2013 - dtm_2013
chm_2013

#plot chm 2013
ggplot() +
geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2013 San Genesio/Jenesien")

# carico i dati del 2004
dsm_2004 <- raster("C:/lab/2004Elevation_DigitalElevationModel-2.5m.tif")
dtm_2004 <- raster("C:/lab/2004Elevation_DigitalTerrainModel-2.5m.tif")

chm_2004 <- dsm_2004 - dtm_2004

#plot chm 2004
ggplot() +
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")

# i due chm hanno due risoluzioni diverse quindi bisogna fare un resample
# del raster che ha una maggior risoluzione (2013) per fare in modo che abbia la stessa
# risoluzione di quello del 2004

chm_2013_res <- resample(chm_2013, chm_2004)

difference <- chm_2013_res - chm_2004

ggplot() +
geom_raster(difference, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("difference in CHM") # giallo positivo è dove è cresciuta pianta, blu negativo è dove non c'è più pianta


library(lidR)
point_cloud




























