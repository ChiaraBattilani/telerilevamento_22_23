# Codice R per visualizzare e analizzare dati LiDAR

library(raster) # carico i pacchetti
library(ggplot2)
library(viridis)
library(RStoolbox)
install.packages("lidR") # installo "lidR" e lo carico
library(lidR)

setwd("C:/lab") # setto la cartella di lavoro su Windows

# Carico i dati dtm e dsm del 2013
dsm_2013 <- raster("C:/lab/2013Elevation_DigitalElevationModel-0.5m.tif")
dtm_2013 <- raster("C:/lab/2013Elevation_DigitalTerrainModel-0.5m.tif")

plot(dtm_2013) # faccio un plot

# Faccio il chm come differenza tra dsm e dtm
chm_2013 <- dsm_2013 - dtm_2013
chm_2013 # Osservo le proprietà

# plot chm 2013 tramite "ggplot"
ggplot() +
geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2013 San Genesio/Jenesien")

# carico i dati dsm e dtm del 2004
dsm_2004 <- raster("C:/lab/2004Elevation_DigitalElevationModel-2.5m.tif")
dtm_2004 <- raster("C:/lab/2004Elevation_DigitalTerrainModel-2.5m.tif")

# Faccio il chm come differenza tra dsm e dtm
chm_2004 <- dsm_2004 - dtm_2004

# plot chm 2004 tramite "ggplot"
ggplot() +
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")

# i due chm hanno due risoluzioni diverse quindi bisogna fare un resample
# del raster che ha una maggior risoluzione (2013) per fare in modo che abbia la stessa
# risoluzione di quello del 2004

chm_2013_res <- resample(chm_2013, chm_2004)

# Confronto i due chm
difference <- chm_2013_res - chm_2004

#plot chm 2004 tramite "ggplot"
ggplot() +
geom_raster(difference, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("difference in CHM") # giallo positivo è dove è cresciuta pianta, blu negativo è dove non c'è più pianta

# Importo il point_cloud tramite la funzione "readLAS"
point_cloud <- readLAS("point_cloud.laz")
plot(point_cloud)
