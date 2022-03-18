# Questo è il primo script che useremo a lezione

library(raster)

#Settaggio cartella di lavoro 
setwd("C:/lab") # Windows

l2011 <- brick("p224r63_2011.grd")

l2011 # plot

plot(l2011) # https://www.r-graph-gallery.com/42-colors-names.html

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

plot(l2011, col=cl) # dev.off()  

