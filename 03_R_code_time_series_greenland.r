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

######################################################
### Example 2: NO2 decrease during the lockdown period
######################################################

library(raster)
setwd("C:/lab/EN") # Windows

# Importo il primo layer
en01 <- raster("EN_0001.png")

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)

en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# Let's import the whole set (altogether!)

# Exercise: import the whole as in the Greenland example by the following steps:
# list.files, lapply, stack

rlist <- list.files(pattern="EN") # creo la lista
rimp <- lapply(rlist, raster) # applico alla lista la funzione raster
en <- stack(rimp) # crea un unico file con i 13 layer

plot(en, col=cl) # plotto tutto assieme

# Exercise: plot EN01 besides EN13
par(mfrow=c(1,2)) # modo 1 con multiframe
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)

# or:
en113 <- stack(en[[1]], en[[13]]) # modo 2 con stack
plot(en113, col=cl)

# let's make the difference:
difen <- en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)

# plotRGB of three files together
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")

sessionInfo() #dà info sula sessione di R
Sys.time() #dà info sulla data e ora attuale

























