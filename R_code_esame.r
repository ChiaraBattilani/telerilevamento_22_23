# Codice R preparato per il progetto d'esame!
# Il codice tratta della perdita di acqua

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
setwd ("C:/lab/esame")

# Importiamo le immagini che andremo ad analizzare: tramite "brick" importo l'immagine e la associo a un nome
mead_2000 <- brick("lakemead_etm_2000188_lrg.jpg")
mead_2022 <- brick("lakemead_oli2_2022184_lrg.jpg")

# Richiamo i due oggetti e osservo le proprietà
mead_2000
# class      : RasterBrick 
# dimensions : 4588, 5505, 25256940, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 5505, 0, 4588  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : lakemead_etm_2000188_lrg.jpg 
# names      : lakemead_etm_2000188_lrg.1, lakemead_etm_2000188_lrg.2, lakemead_etm_2000188_lrg.3 
# min values :                          0,                          0,                          0 
# max values :                        255,                        255,                        255 

mead_2022
# class      : RasterBrick 
# dimensions : 4588, 5505, 25256940, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 5505, 0, 4588  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : lakemead_oli2_2022184_lrg.jpg 
# names      : lakemead_oli2_2022184_lrg.1, lakemead_oli2_2022184_lrg.2, lakemead_oli2_2022184_lrg.3 
# min values :                           0,                           0,                           0 
# max values :                         255,                         255,                         255 

# Faccio un primo plot per osservare le tre bande
plot(mead_2000)
plot(mead_2022)

# Salvo entrambi i plot in formato png
png("mead2000_bande.png") 
plot(mead_2000, main="Lago Mead 2000")
dev.off()

png("mead2022_bande.png") 
plot(mead_2022, main="Lago Mead 2022")
dev.off()

# Cambio la scala di colori per poter fare migliori osservazioni
cl <- colorRampPalette(c("#FFFFCC", "#CEE2AC", "#9BC592", "#65A87D", "#218B6D", "#006E61")) (100)

# Salvo i plot con la nuova scala di colori
png("mead2000_bande_CL.png") 
plot(mead_2000, col=cl, main="Lago Mead 2000")
dev.off()

png("mead2022_bande_CL.png") 
plot(mead_2022, col=cl, main="Lago Mead 2022")
dev.off()

# Tramite la funzione "ggRGB" del pacchetto ggplot2, ottengo il raster con la colorazione reale dell'immagine; le bande sono nell'ordine:
# red = banda 1
# green = banda 2
# blue = banda 3
m1 <- ggRGB(mead_2000,r=1,g=2,b=3, stretch="lin") # utilizzo uno stretch lineare
m2 <- ggRGB(mead_2022,r=1,g=2,b=3, stretch="lin") # utilizzo uno stretch lineare

