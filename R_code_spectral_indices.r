library(raster)

# Settaggio WD in Windows
setwd("C:/lab")

# Exercise: import the first file -> defor1_.jpg -> give it the name l1992
l1992 <- brick("defor1_.jpg")

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green

# Exercise: import the second file -> defor2_.jpg -> give it the name l2006
l2006 <- brick("defor2_.jpg")

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Exercise: plot in multiframe the two images with one on top of the other
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index 1992
# Potevo usare anche assegnazione <-
dvi1992 = l1992[[1]] - l1992[[2]]
# or:
# dvi1992 = l1992$defor1_.1- l1992$defor1_.2
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

