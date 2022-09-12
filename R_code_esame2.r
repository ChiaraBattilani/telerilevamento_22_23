# Codice R preparato per il progetto d'esame!
# Il codice tratta della

# Innanzitutto installiamo e carichiamo i pacchetti utili per far funzionare il codice
# install.packages ("raster")
library (raster)
# install.packages ("rasterVis")
#library (rasterVis)
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
png("bahrain1987_bande.png") 
plot(bahrain_1987, main="Bahrain 1987")
dev.off()

png("bahrain2022_bande.png") 
plot(bahrain_2022, main="Bahrein 2022")
dev.off()

# Cambio la scala di colori per poter fare migliori osservazioni
cl <- colorRampPalette(c("#FFFFCC", "#CEE2AC", "#9BC592", "#65A87D", "#218B6D", "#006E61")) (100)

# Salvo i plot con la nuova scala di colori
png("bahrain1987_bandeCL.png") 
plot(bahrain_1987, col=cl, main="Bahrein 1987")
dev.off()

png("bahrain2022_bandeCL.png") 
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
png("a1_a2.png", 900, 900) 
plot(a1+a2)
dev.off()

#####

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

png("bahrain1987_pca.png", 900, 900) # Salvo il plot
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

png("bahrain2022_pca.png", 900, 900) # Salvo il plot
plot(bahrain2022_pca$map)
dev.off()

#####

# Rilevo l'aumento delle costruzioni
# Assegno le componenti dell'immagine ad un nome
ba1_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.1
ba2_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.2
ba3_1987 <- bahrain_1987$bahrain_tm5_1987229_lrg.3

g1 <- ggplot() + 
geom_raster(bahrain1987_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "viridis") +
ggtitle("PC1")

ba1_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.1
ba2_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.2
ba3_2022 <- bahrain_2022$bahrain_oli_2022229_lrg.3

# Salvo i plot delle precedenti componenti
png("ba1_1987", 900, 900) # Salvo il plot
plot(ba1_1987$map)
dev.off()
