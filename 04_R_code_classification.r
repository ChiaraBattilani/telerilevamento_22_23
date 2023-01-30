library(raster) # Carico i pacchetti
library(RStoolbox)

setwd("C:/lab") # setto la cartella di lavoro su Windows

# Importo l'immagine RGB tramite "brick"
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin") # plot in forma lineare e a istogramma
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifico l'immagine in base alla disposizione dei pixel nello spazio delle tre bande, e per farlo
# utilizzo "unsuperClass", con cui scelgo il numero di classi volute
soc <- unsuperClass(so, nClasses=3)

cl <- colorRampPalette(c('yellow','black','red'))(100) # creo una nuova scala di colori
plot(soc$map, col=cl)

# set.seed può essere utilizzato per ripetere l'esperimento nella stessa maniera per N volte
# http://rfunction.com/archives/62

###################
# Grand Canyon

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") # Importo l'immagine e visualizzo i parametri
gc

# Bande:
# rosso = 1
# verde = 2
# blu = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# cambio lo stretch in modalità istogramma, così ho un maggior contrasto
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# classificazione
gcclass2 <- unsuperClass(gc, nClasses=2)
gcclass2

plot(gcclass2$map)
# set.seed(17) fa solo una delle N ripetizioni fatte, così posso mantenere la stessa classificazione

# Esercizio: classifica la mappa in 4 classi
gcclass4 <- unsuperClass(gc, nClasses=4)
gcclass4

clc <- colorRampPalette(c('yellow','red','blue', 'black'))(100) # creo una scala di colori
plot(gcclass4$map, col=clc)

# Confronto la mappa con la classificazione con quella originale
par(mfrow=c(2,1))
plot(gcclass4$map, col=clc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

st <- stack(gc, gcclass4$map) # visualizzo anche tramite uno stack
plot(st)
