# Codice per generare la land cover da un'immagine satellitare
# install.packages("ggplot2") # pacchetto che visualizza dati in modo elegante
# per info: https://ggplot2-book.org/
# install.packages("patchwork") # pacchetto per semplici multiframe
# per info: https://patchwork.data-imaginist.com/

library(raster) # Installo i pacchetti
library(RStoolbox) # per classificazione
library(ggplot2)
library(patchwork)

setwd("C:/lab") # Setto la cartella di lavoro su Windows

# Bande:
# NIR = 1
# r = 2
# g = 3

# importazione immagini
l92 <- brick("defor1_.jpg") # img del 1992
plotRGB(l92, 1, 2, 3, stretch="lin") # non scrivo r=1, g=2, B=3 perchè so che rgb sono in fila come 1 2 3

# Esercizio: importo defor2 e plotto entrambe le immagini in una finestra unica
l06 <- brick("defor2_.jpg") # img del 2006

par(mfrow=c(2,1))
plotRGB(l92, 1, 2, 3, stretch="lin")
plotRGB(l06, 1, 2, 3, stretch="lin")

# Faccio un semplice multiframe con ggplot2
ggRGB(l92, 1, 2, 3, stretch="lin")
ggRGB(l06, 1, 2, 3, stretch="lin")

p1 <- ggRGB(l92, 1, 2, 3, stretch="lin") # assegno i plot a un nome così ottengo due oggetti
p2 <- ggRGB(l06, 1, 2, 3, stretch="lin")
p1+p2 # grazie a patchwork posso affiancare le immagini
p1/p2 # uno sotto all'altro

# Classificazione
l92c <- unsuperClass(l92, nClasses=2) # ottego un modello di l92
l92c # visualizzo i parametri
plot(l92c$map)
# classe 1 : aree agricole (+ acqua)
# classe 2 : foresta

# Esercizio: classifica l'immagine Landsat del 2006 tramite "unsuperClass"
l06c <- unsuperClass(l06, nClasses=2)
l06c
plot(l06c$map)
# classe 1 : foresta
# classe 2 : aree agricole (+ acqua)

# Frequenze: calcolo la frequenza di pixel apparteneneti alla classe della foresta e alla classe delle aree agricole (+ acqua)
freq(l92c$map)
# class 1:  35333 pixels (aree agricole (+ acqua))
# class 2: 305959 pixels (foresta)

# Pixel totali
tot92 <- 341292

# Proporzione della classe foresta
prop_forest_92 <- 305959 / tot92

# Percentuale della classe foresta
perc_forest_92 <- 305959 * 100 / tot92

# Eserczio: calcola la percentuale delle aree agricole del 1992
# metodo 1
perc_agr_92 <- 100 - perc_forest_92
# metodo 2
perc_agr_92 <- 35333 * 100 / tot92

# percent_forest_92: 89.64728
# percent_agr_92: 10.35272

# Frequenza 2006
freq(l06c$map)
# class 1: 178151 pixels (forest)
# class 2: 164575 pixels (agricultural areas (+ water))

# Percentuale 2006
tot06 <- 342726
percent_forest_06 <- 178151 * 100 / tot06
percent_agr_06 <- 100 - percent_forest_06

# percent_forest_06: 51.98059
# percent_agr_06: 48.01941

# DATI FINALI:
# percent_forest_92: 89.64728
# percent_agr_92: 10.35272
# percent_forest_06: 51.98059
# percent_agr_06: 48.01941

# Costruire un dataframe con i dati ottenuti
# Colonne (campi)
class <- c("Forest", "Agriculture")
percent_1992 <- c(89.64728, 10.35272)
percent_2006 <- c(51.98059, 48.01941)

# la prima colonna è la classe, la seconda le percentuali del 1992 e la terza le percentuali del 2006
multitemporal <- data.frame(class, percent_1992, percent_2006)

# 1992
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) + 
geom_bar(stat="identity", fill="white")

# Esercizio: fai ostesso grafico per il 2006
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
