# Time series analysis of Greenland LST data

library(raster)

setwd("C:/lab/Greenland") # Windows

# Importo dati come al solito
lst2000 <- raster("lst_2000.tif")
lst2000

# Exercise: import all the data
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# Exercise: multiframe of greenland data
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)

# Import the whole set altogether!
rlist <- list.files(pattern="lst") # creo la lista
rlist
import <- lapply(rlist, raster) # importo tutto assieme
import

tgr <- stack(import) # crea un unico file con i 4 layer
tgr

plot(tgr, col=cl) # plot di tutti e 4
plot(tgr[[1]], col=cl) # plot del 1° elemento

plotRGB(tgr, r=1, g=2, b=3, stretch="lin") # sovrapposizione temporale









