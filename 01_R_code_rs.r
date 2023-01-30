# Questo è il primo script che useremo a lezione

# Installo il pacchetto "raster" per lavorare su file in questo formato tramite Install.packages ("raster") e poi lo richiamo
library(raster)

# Settaggio cartella di lavoro 
setwd("C:/lab") # Windows

# import
# Assegno all'oggetto "l2011" la funzione "brick" così importo l'immagine
l2011 <- brick("p224r63_2011.grd")
l2011 # chiamo l'oggetto per vedere le proprietà come dimensioni, classe, ecc.

plot(l2011) # plot dell'oggetto, vedo le bande di riflettanza

# https://www.r-graph-gallery.com/42-colors-names.html
# trmite colorRampPalette cambio i colori nell'immagine per poter fare migliori osservazioni
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

plot(l2011, col=cl) # "col" definisce i colori, nuovo plot con colori diversi dal precedente

# dev.off() # Chiude finestra grafica

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# diversi metodi di plot della banda del blu - B1_sre
plot(l2011$B1_sre) # plotto il nome dell'oggetto riferito alla banda blu
# il $ serve per legare due oggetti
# or
plot(l2011[[1]]) # plotto l'elemento numero 1, che corrisponde alla banda blu

# plot di b1 con scala di colori da black a grey a light grey
plot(l2011$B1_sre)
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot b1 da dark blue a blue a light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# Esporto l'immagine nel formato che voglio (pdf) e la salvo nella cartella di lavoro
pdf("banda1.pdf") # dice solo qual è il nome del pdf da creare
plot(l2011$B1_sre, col=clb)
dev.off()

# rifaccio l'eportazione ma in formato png
png("banda1.png") 
plot(l2011$B1_sre, col=clb)
dev.off()

# plot b2 (banda verde) con scala di colori da dark green a green a light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

# multiframe
# Creo un multiframe in cui identifico il numero di righe (una) e colonne (due), così posso avere il plot di
# b1 e di b2 assieme
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off() # lo inserisco solo se devo chiudere la modalità di vsualizzazione, se no continua a fare finestre a 2 img

# Esporto il plot del multiframe e lo salvo
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# Esercizio: crea multiframe a 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# Creo multiframe (2 righe 2 colonne) con le quattro bande: blu, verde, rosso, infrarosso
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb)
# green
plot(l2011$B2_sre, col=clg)
# Per le bande rosso e infrarosso devo anche inserire le scale di colore
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# Day #3

# Plot di l2011 nella banda NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
# or
plot(l2011[[4]])

# Schema RGB, può utilizzare solo 3 bande per volta, lo plotto in differenti modi
# Assegnando la banda 3 a r, la 2 a g e la 1 a b, ottengo un'immagine a colori naturali
plotRGB(l2011, r=3, g=2, b=1, stretch="lin") # "stretch" allunga le bande in modo da non sovrastarne una rispetto all'altra nella visualizzazione
plotRGB(l2011, r=4, g=3, b=2, stretch="lin") # metto NIR in r per avere una risoluzione infrarossa (risalta la vegetazione per l'alta riflettanza)
plotRGB(l2011, r=3, g=4, b=2, stretch="lin") # metto NIR in g e ho una visione diversa della foresta, il viola è suolo nudo
plotRGB(l2011, r=3, g=2, b=4, stretch="lin") # metto NIR in b e visualizzo meglio il suolo nudo

# Uso lo stretch "hist" per allungare ulteriormente la banda e dare potenze medie più elevate
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Esercizio: costruire un multiframe con in alto la scala del visibile RGB (linear stretch) e in basso la scala RGB con il NIR (histogram stretch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Esercizio: caricare immagine del 1988 e visualizzare proprietà
l1988 <- brick("p224r63_1988.grd")
l1988

# Fare multiframe: sopra img 1988 e sotto img 2011
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
