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

# legenda
legend_timecycle(pal, origin_label = "1 jan") 

# mappare il comportamento individuale di un individuo nel tempo, non è più un tempo circolare, è lineare

# fisher ----
data("fisher_ud")
m2 <- metrics_pull(fisher_ud)
pal2 <- palette_timeline(fisher_ud)
head(pal2)

# map multiple
map_multiples(m2, pal2, ncol = 3, lambda_i = -12) # lambda lavora sull'opacità
m2_distill <- metrics_distill(fisher_ud)
map_single(m2_distill, pal2, lambda_i = -10)
legend_timeline(pal2)












