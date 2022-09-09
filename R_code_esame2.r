# Codice R preparato per il progetto d'esame!
# Il codice tratta della

# Innanzitutto installiamo e carichiamo i pacchetti utili per far funzionare il codice
# install.packages ("raster")
library (raster)
# install.packages ("rasterVis")
library (rasterVis)
# install.packages ("RStoolbox") # per calcolare la PCA
library (RStoolbox)
# install.packages ("ggplot2") # per fare i plot con ggplot
library (ggplot2)
# install.packages ("gridExtra") # per fare un plot con più ggplots assieme
library (gridExtra)

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
b1 <- ggRGB(bahrain_1987, r=1, g=2, b=3, stretch="lin") # utilizzo uno stretch lineare
b2 <- ggRGB(bahrain_2022, r=1, g=2, b=3, stretch="lin") # utilizzo uno stretch lineare

# Faccio un plot in cui inserisco b1 e b2, tramite la funzione "grid.arrange", e lo salvo come png
b1_b2 <- grid.arrange (b1,b2, nrow=1, ncol=2)
plot(b1_b2)
png("b1_b2.png", 900, 900) 
plot(b1_b2)
dev.off()

# Svolgo il calcolo della PCA: utilizzo quindi la funzione ""rasterPCA"
mead2000_pca <- rasterPCA(mead_2000)
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About



bahrain1987_pca <- rasterPCA(bahrain_1987)
