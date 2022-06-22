# Packages----
install.packages("colorist")
 
library(colorist) # colorist lavora con pile di raster, non con altre tipologie di file
library(ggplot2)

# Field sparrow----

data("fiespa_occ") # file con dati degli uccelli

# creo metriche
met1 <- metrics_pull(fiespa_occ)

# creazione palette
pal <- palette_timecycle(fiespa_occ)

# creo mappa per capire dove sono i dati, creo mappa multipla
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

map_single(met1, pal, layer = 6) #estraggo un solo mese, layer indica il mese

# se vogliamo cambiare il colore dentro la mappa
pl_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, pl_custom, labels =  names(fiespa_occ), ncol = 4)

# distilliamo la mappa
met1_distill <- metrics_distill(fiespa_occ)

map_single(met1_distill, pal) # parti più colorate hanno una maggior specificità per un singolo layer
# in questo caso i mesi (ovvero le specie stanno per un certo mese in quella zona), le parti grigie
# riguardano quelle con minor specificità, ovvero in questo caso significa che le specie sono presenti
# nelle zone grigie per la maggior parte dei mesi.





























