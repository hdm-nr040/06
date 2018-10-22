install.packages("igraph") # installiert igraph Paket
install.packages("igraphdata") # installiert igraphdata Paket mit Datensätzen
install.packages("intergraph") # installiert intergraph Paket für den Datenaustausch

library(igraph) # grundlegendes Basispakete
library(igraphdata) # zusätzliche Datenpakete

library(intergraph) # Datenübergabe zwischen Bibliotheken

?igraphdata # Hilfefunktion zu dem Paket

el <- read.csv(file.choose(), header=T, as.is=T, sep = ",")
nodes <- read.csv(file.choose(), header=T, as.is=T, sep = ",")
# prüft, ob alle Vari

head(el)
head(nodes)

hties <-as.matrix(el)

stuggi <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
stuggi
edge_density(stuggi)
#0.02702703 entspricht 2,7 %
transitivity(stuggi, type=c("global"))
#nachher ausf�hren - kleine Welt-Ph�nomen, bei hohem Wert

# Wir wollen das Ego-Netzwerk von "Relumity", also rel beobachten.

EgoCon <- make_ego_graph(stuggi, order = 1, nodes = V(stuggi)$id == "tti", mode = "all")
EgoCon
plot(EgoCon[[1]])


E(stuggi)$color <- "pink"
V(stuggi)[branche == "commerce"]$color <- "darkred"
V(stuggi)[branche == "tech"]$color <- "grey"
V(stuggi)[branche == "service"]$color <- "yellow"
V(stuggi)[branche == "fin"]$color <- "green"
V(stuggi)[branche == "m"]$color<- "purple"
V(stuggi)[branche == "sa"]$color<- "purple"
V(stuggi)[branche == "gs"]$color<- "orange"
V(stuggi)[branche == "tti"]$color<- "orange"
V(stuggi)[branche == "ind"]$color<- "white"
V(stuggi)[branche == "health"]$color<- "blue"
E(stuggi)$arrow.size <- .4

par(mfrow=c(2,2), mar=c(0,0,3,0))



st1 <- subgraph.edges(stuggi,E(stuggi)[weight >= 2])
st2 <- subgraph.edges(stuggi,E(stuggi)[weight <=1])

plot(stuggi, layout=layout_with_kk, vertex.label.dist=3, vertex.label.family = "Gujarati Sangam MN",main="Startups-Stuttgart")

plot(st1, layout=layout_with_kk, vertex.label.dist=3, vertex.label.family = "Gujarati Sangam MN",main="Funding-Startups")

plot(st2, layout=layout_with_kk, vertex.label.dist=3, vertex.label.family = "Gujarati Sangam MN",main="Beratungs-Startups") 

