# Code for generating land cover from satellite image

# install.packages("ggplot2") # pacchetto che visualizza dati in modo elegante
# for info: https://ggplot2-book.org/
# install.packages("patchwork") # pacchetto per semplici multiframe
# for info: https://patchwork.data-imaginist.com/

library(raster)
library(RStoolbox) # for classification
library(ggplot2)
library(patchwork)

setwd("C:/lab")

# NIR = 1
# r = 2
# g = 3

# importazione immagini
l92 <- brick("defor1_.jpg") # img del 1992
plotRGB(l92, 1, 2, 3, stretch="lin") # non scrivo r=1, g=2, B=3 perchè so che rgb sono in fila come 1 2 3

# Exercise: import defor2 and plot both in a single window
l06 <- brick("defor2_.jpg") # img del 2006

par(mfrow=c(2,1))
plotRGB(l92, 1, 2, 3, stretch="lin")
plotRGB(l06, 1, 2, 3, stretch="lin")

# making a simple multiframe with ggplot2
ggRGB(l92, 1, 2, 3, stretch="lin")
ggRGB(l06, 1, 2, 3, stretch="lin")

p1 <- ggRGB(l92, 1, 2, 3, stretch="lin") # assegno i plot a un nome così ottengo due oggetti
p2 <- ggRGB(l06, 1, 2, 3, stretch="lin")
p1+p2 # thanks to patchwork! uno affianco all'altro
p1/p2 # uno sotto all'altro

# classification
l92c <- unsuperClass(l92, nClasses=2) # ottego un modello di l92
l92c
plot(l92c$map)
# class 1 : agricultural areas (+ water)
# class 2 : forest

# Exercise: classify the Landsat image from 2006
l06c <- unsuperClass(l06, nClasses=2)
l06c
plot(l06c$map)
# class 1 : forest
# class 2 : agricultural areas (+ water)

# Frequencies
freq(l92c$map)
# class 1:  35333 pixels (agricultural areas (+ water))
# class 2: 305959 pixels (forest)

tot92 <- 341292

# proportion of classes
prop_forest_92 <- 305959 / tot92

# percent of classes
perc_forest_92 <- 305959 * 100 / tot92

# Exercise: calculate the percentage of agricultural areas in 1992
# method 1
perc_agr_92 <- 100 - perc_forest_92
# method 2
perc_agr_92 <- 35333 * 100 / tot92

# percent_forest_92: 89.64728
# percent_agr_92: 10.35272

freq(l06c$map)
# class 1: 178151 pixels (forest)
# class 2: 164575 pixels (agricultural areas (+ water))

# percentage 2006
tot06 <- 342726
percent_forest_06 <- 178151 * 100 / tot06
percent_agr_06 <- 100 - percent_forest_06

# percent_forest_06: 51.98059
# percent_agr_06: 48.01941

# FINAL DATA:
# percent_forest_92: 89.64728
# percent_agr_92: 10.35272
# percent_forest_06: 51.98059
# percent_agr_06: 48.01941

# Let's build a dataframe with our data
# Columns (fields)
class <- c("Forest", "Agriculture")
percent_1992 <- c(89.64728, 10.35272)
percent_2006 <- c(51.98059, 48.01941)

multitemporal <- data.frame(class, percent_1992, percent_2006)

# 1992
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + 
geom_bar(stat="identity", fill="white")

# Exercise: make the same graph for 2006
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) + 
geom_bar(stat="identity", fill="white")

# pdf
pdf("percentages_1992.pdf")
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + 
geom_bar(stat="identity", fill="white")
dev.off()

pdf("percentages_2006.pdf")
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) + 
geom_bar(stat="identity", fill="white")
dev.off()













