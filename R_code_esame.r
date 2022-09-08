# Codice R preparato per il progetto d'esame!
# Il codice tratta della perdita di acqua

# Innanzitutto installiamo e carichiamo i pacchetti utili per far funzionare il codice
# install.packages ("raster")
library (raster)
# install.packages ("rasterVis")
library (rasterVis)
# install.packages ("RStoolbox") # to calcolate PCA
library (RStoolbox)
# install.packages ("ggplot2") # to plot with ggplot
library (ggplot2)
# install.packages ("gridExtra") # to plot the ggplots together
library (gridExtra)

# Settiamo la cartella di lavoro, in questo caso su Windows
setwd ("C:/lab/esame")

# Importiamo le immagini che andremo ad analizzare: tramite "brick" importo l'immagine e la associo a un nome
mead_2000 <- brick("lakemead_etm_2000188_lrg.jpg")
mead_2022 <- brick("lakemead_oli2_2022184_lrg.jpg")

# Richiamo i due oggetti e osservo le proprietà
mead_2000
mead_2022

# Faccio un primo plot per osservare le tre bande
plot(mead_2000)
plot(mead_2022)

# Cambio la scala di colori per poter fare migliori osservazioni
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

png("mead2000_bande.png") 
plot(mead_2000)
dev.off()
