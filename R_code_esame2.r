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
setwd ("C:/lab/esame2")

# Importiamo le immagini che andremo ad analizzare: tramite "brick" importo l'immagine e la associo a un nome
bahrain_1987 <- brick("bahrain_tm5_1987229_lrg.jpg")
bahrain_2022 <- brick("bahrain_oli_2022229_lrg.jpg")


bahrain1987_pca <- rasterPCA(bahrain_1987)
