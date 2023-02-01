# Codice R per creare funzioni 

library(raster) # carico i pacchetti
setwd("C:/lab") # Setto la cartella di lavoro su Windows

# FUNZIONE 1
# una volta chiamata, la funzione "saluta" il nome inserito
cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}

cheer_me("chiara")

# FUNZIONE 2
# una volta chiamata, "saluta" il nome inserito n volte, dove "n" lo scelgo io
cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}
cheer_me_n_times("chiara", 5)

# FUNZIONE 3
# una volta richiamata un'immagine dalla cartella di lavoro, posso scegliere se plottarla con
#una palette creata da me o lasciare quella di default
dato <- raster("sentinel.png")

plot(dato)

plot_raster <- function(r, col = NA) {
if(!is.na(col)) {
pal <- colorRampPalette(col) (100)
plot(r, col = pal)
} else {
plot(r)
}

}

plot_raster(dato, c("brown", "yellow", "green"))
plot_raster(dato)
