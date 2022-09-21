# Codice R preparato per il progetto d'esame!
# Il codice è stato creato per analizzare le variazioni che vi sono state in Bahrein per quanto
# riguarda l'aumento di aree in cui sono state fatte costruzioni tra il 1987 e il 2022.

# I dati sono stati presi nel seguente sito: https://earthobservatory.nasa.gov/images/150313/building-bahrain

# Innanzitutto installiamo e carichiamo i pacchetti utili per far funzionare il codice
# install.packages ("raster")
library (raster)
# install.packages ("RStoolbox") # per calcolare la PCA
library (RStoolbox)
# install.packages ("ggplot2") # per fare i plot con ggplot
library (ggplot2)
# install.packages ("patchwork") # per fare un plot con più ggplots assieme
library(patchwork)
# install.packages ("viridis") # per avere differenti scale di colore
library(viridis)

# Settiamo la cartella di lavoro, in questo caso su Windows
setwd ("C:/lab/esame2")

# Importiamo le immagini che andremo ad analizzare: tramite "brick" importo l'immagine e la associo a un nome
bahrain_1987 <- brick("bahrain_tm5_1987229_lrg.jpg")
bahrain_2022 <- brick("bahrain_oli_2022229_lrg.jpg")

# Richiamo i due oggetti e osservo le proprietà
bahrain_1987
# class      : RasterBrick 
# dimensions : 2112, 1901, 4014912, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 1901, 0, 2112  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : bahrain_tm5_1987229_lrg.jpg
# names      : bahrain_tm5_1987229_lrg.1, bahrain_tm5_1987229_lrg.2, bahrain_tm5_1987229_lrg.3 
# min values :                          0,                          0,                          0 
# max values :                        255,                        255,                        255 

bahrain_2022
# class      : RasterBrick 
# dimensions : 2112, 1901, 4014912, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 1901, 0, 2112  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : bahrain_oli_2022229_lrg.jpg 
# names      : bahrain_oli_2022229_lrg.1, bahrain_oli_2022229_lrg.2, bahrain_oli_2022229_lrg.3
# min values :                           0,                           0,                           0 
# max values :                         255,                         255,                         255 

# Faccio un primo plot per osservare le tre bande
plot(bahrain_1987)
plot(bahrain_2022)

# Salvo entrambi i plot in formato png
png("bahrain1987_bande.png", 600, 600) 
plot(bahrain_1987, main="Bahrain 1987")
dev.off()

png("bahrain2022_bande.png", 600, 600) 
plot(bahrain_2022, main="Bahrein 2022")
dev.off()

# Cambio la scala di colori per poter fare migliori osservazioni
cl <- colorRampPalette(c("#FFFFCC", "#CEE2AC", "#9BC592", "#65A87D", "#218B6D", "#006E61")) (100)

# Salvo i plot con la nuova scala di colori
png("bahrain1987_bandeCL.png", 600, 600) 
plot(bahrain_1987, col=cl, main="Bahrein 1987")
dev.off()

png("bahrain2022_bandeCL.png", 600, 600) 
plot(bahrain_2022, col=cl, main="Bahrein 2022")
dev.off()

# Tramite la funzione "plotRGB" e "ggRGB" del pacchetto ggplot2, ottengo il raster con la colorazione reale dell'immagine; le bande sono nell'ordine:
# red = banda 1
# green = banda 2
# blue = banda 3
plotRGB(bahrain_1987, r=1, g=2, b=3, stretch="lin")
plotRGB(bahrain_2022, r=1, g=2, b=3, stretch="lin")
a1 <- ggRGB(bahrain_1987, r=1, g=2, b=3, stretch="lin") # utilizzo uno stretch lineare
a2 <- ggRGB(bahrain_2022, r=1, g=2, b=3, stretch="lin") # utilizzo uno stretch lineare

# Faccio un plot affiancando a1 e a2, tramite il segno "+", e lo salvo come png
png("a1_a2.png", 600, 600) 
plot(a1+a2)
dev.off()

#################

# Svolgo il calcolo della PCA: utilizzo quindi la funzione "rasterPCA"
# Anno 1987
bahrain1987_pca <- rasterPCA(bahrain_1987)
bahrain1987_pca # Visualizzo le proprietà: call, model, map
plot(bahrain1987_pca$map) # Plot per visualizzare le componenti
summary(bahrain1987_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
# Standard deviation     106.2537273 8.51188543 4.114986375
# Proportion of Variance   0.9921449 0.00636705 0.001488071
# Cumulative Proportion    0.9921449 0.99851193 1.000000000

# Faccio un plot della PCA map 1987 e lo salvo come png
png("bahrain1987_pca.png", 600, 600) # Salvo il plot
plot(bahrain1987_pca$map)
dev.off()

# Anno 2022
bahrain2022_pca <- rasterPCA(bahrain_2022)
bahrain2022_pca
plot(bahrain2022_pca$map)
summary(bahrain2022_pca$model)
# Importance of components:
#                             Comp.1      Comp.2      Comp.3
# Standard deviation     111.5726953 7.476395518 4.434248443
# Proportion of Variance   0.9939669 0.004463141 0.001569987
# Cumulative Proportion    0.9939669 0.998430013 1.000000000

# Faccio un plot della PCA map 2022 e lo salvo come png
png("bahrain2022_pca.png", 600, 600) # Salvo il plot
plot(bahrain2022_pca$map)
dev.off()

#################

# Rilevo l'aumento delle costruzioni
# Assegno le componenti dell'immagine relativa al 1987 ad un nome
ba1_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.1
ba2_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.2
ba3_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.3

# Faccio un plot di ciascuna componente tramite "ggplot" e il pacchetto di colori "viridis"
g1 <- ggplot() + 
geom_raster(bahrain1987_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g2 <- ggplot() + 
geom_raster(bahrain1987_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC2")

g3 <- ggplot() + 
geom_raster(bahrain1987_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC3")

# Faccio un plot delle tre componenti del 1987 e lo salvo come png
png("ba_1987_.png", 900, 300)
plot(g1+g2+g3, col=cl, main="Componenti principali dell'analisi")
dev.off()

# Assegno le componenti dell'immagine relativa al 2022 ad un nome
ba1_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.1
ba2_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.2
ba3_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.3

# Faccio un plot di ciascuna componente tramite "ggplot" e il pacchetto di colori "viridis"
gg1 <- ggplot() + 
geom_raster(bahrain2022_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

gg2 <- ggplot() + 
geom_raster(bahrain2022_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC2")

gg3 <- ggplot() + 
geom_raster(bahrain2022_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC3")

# Faccio un plot delle tre componenti del 2022 e lo salvo come png
png("ba_2022.png", 900, 300)
plot(gg1+gg2+gg3, col=cl, main="Componenti principali dell'analisi")
dev.off()

# Calcolo la differenza tra la componente 1 del 1987 rispetto a quella del 2022
# Utilizzo la componente 1 perchè risulta essere quella che ha una varianza maggiore per entrambe le annate (99%)
dif <- ba1_1987 - ba1_2022

# Per visualizzarla meglio nel plot cambio la scala di colori, e poi lo salvo come png
plot(dif, col=cl, main = "Aumento delle costruzioni")
png("dif.png", 600, 600)
plot(dif, col=cl, main = "Aumento delle costruzioni tra 1987 e 2022")
dev.off()

#################

# Calcolo della deviazione standard
# La calcolo tramite la funzione "focal", la quale si basa sulla deviazione standard
# In questo caso utilizziamo una finestra di 3x3 pixels
ds3 <- focal(dif, matrix(1/9, 3, 3), fun=sd)
# Faccio un plot della deviaizone dtandard con una nuova scala di colori per visualizzarla meglio, e lo salvo come png
clds <- colorRampPalette(c('blue','green','pink','magenta','red','orange','yellow'))(100) # Creo una nuova scala di colori
plot(ds3, col=clds)

png("ds3.png", 600, 600)
plot(ds3, col=clds, main="Deviazione standard")
dev.off()

##########################
# Svolgo la classificazione
# Anno 1987
b1987c <- unsuperClass(bahrain_1987, nClasses=2) # ottego un modello di bahrain_1987
b1987c # visualizzo i parametri
plot(b1987c$map) # Faccio un plot e lo salvo come png
png("b1987c.png", 600, 600) 
plot(b1987c$map, main="Classificazione anno 1987")
dev.off()
# Nel caso del plot salvato in png:
# classe 1 : mare (bianco)
# classe 2 : area costruita (verde)

# Anno 2022
b2022c <- unsuperClass(bahrain_2022, nClasses=2) # ottego un modello di bahrain_2022
b2022c # visualizzo i parametri
plot(b2022c$map) # Faccio un plot e lo salvo come png
png("b2022c.png", 600, 600) 
plot(b2022c$map, main="Classificazione anno 2022")
dev.off()
# Nel caso del plot salvato in png:
# classe 1 : mare (bianco)
# classe 2 : area costruita (verde)

# Calcolo le frequenze
# Anno 1987
freq(b1987c$map)
# Nel caso del plot salvato in png:
# classe 1: 3354756 pixels (mare)
# classe 2:  660156 pixels (area costruita)
tot1987 <- 4014912

# Percentuale delle classi "area costruita" e "mare"
perc_costr_1987 <- 660156 * 100 / tot1987 # 16.4426 %
perc_mare_1987 <- 3354756 * 100 / tot1987 # 83.5574 %

# Anno 2022
freq(b2022c$map)
# Nel caso del plot salvato in png:
# classe 1: 3234415 pixels (mare)
# classe 2:  780497 pixels (area costruita)
tot2022 <- 4014912

# Percentuale delle classi "area costruita" e "mare"
perc_costr_2022 <- 780497 * 100 / tot2022 # 19.43995 %
perc_mare_2022 <- 3234415 * 100 / tot2022 # 80.56005 %

# Costrusco un dataframe con i dati ottenuti, le colonne saranno : classi, percentuali del 1987 e percentuali del 2022
classi <- c("Area costruita", "Mare")
perc_1987 <- c(16.4426, 83.5574)
perc_2022 <- c(19.43995, 80.56005)
multitemporal <- data.frame(classi, perc_1987, perc_2022)

# Tramite ggplot creo un grafico a barre per mostrare le percentuali di "area costruita" e "mare" nel 1987 e lo salvo come png
bar1987 <- ggplot(multitemporal, aes(x=classi, y=perc_1987, fill=classi)) + 
geom_bar(stat="identity", color="black") +
scale_fill_manual(values=c("#009900", "#FFFFFF")) +
geom_text(aes(label = perc_1987), vjust= -0.3, size= 4.5) +
theme_minimal()

png("bar1987.png", 600, 600) # Faccio un plot e lo salvo come png
plot(bar1987)
dev.off()

# Tramite ggplot creo un grafico a barre per mostrare le percentuali di "area costruita" e "mare" nel 2022 e lo salvo come png
bar2022 <- ggplot(multitemporal, aes(x=classi, y=perc_2022, fill=classi)) + 
geom_bar(stat="identity", color="black") +
scale_fill_manual(values=c("#009900", "#FFFFFF")) +
geom_text(aes(label = perc_2022), vjust= -0.3, size= 4.5) +
theme_minimal()

png("bar2022.png", 600, 600) # Faccio un plot e lo salvo come png
plot(bar2022)
dev.off()
