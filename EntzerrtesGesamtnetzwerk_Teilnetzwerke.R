install.packages("igraph") # installiert igraph Paket
install.packages("igraphdata") # installiert igraphdata Paket mit DatensÃ¤tzen
install.packages("intergraph") # installiert intergraph Paket fÃ¼r den Datenaustausch

library(igraph) # grundlegendes Basispakete
library(igraphdata) # zusÃ¤tzliche Datenpakete

library(intergraph) # DatenÃ¼bergabe zwischen Bibliotheken

?igraphdata # Hilfefunktion zu dem Paket

el <- read.csv("https://raw.githubusercontent.com/hdm-nr040/06/master/edgelist_final.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-nr040/06/master/nodelist.csv", header=T, as.is=T, sep = ",")
# prüft, ob alle Vari

head(el)
head(nodes)

hties <-as.matrix(el)

stuggi <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
stuggi
edge_density(stuggi)
#0.02702703 entspricht 2,7 %
transitivity(stuggi, type=c("global"))
#nachher ausführen - kleine Welt-Phänomen, bei hohem Wert




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

coords <- layout_with_kk(stuggi)*2

plot(stuggi, layout=coords, rescale=FALSE,ylim=c(-4.6,8.6),xlim=c(-2.5,1), asp= 0.5,edge.width = 2,edge.curved=TRUE, vertex.label.font=2,vertex.size=23, vertex.label.dist=5,vertex.label.degree = pi/-2, vertex.label.cex=.5,vertex.label.family = "Arial",edge.arrow.size=0.2,main="Startups-Stuttgart")


par(mfrow=c(1,1), mar=c(0,0,3,0))



st1 <- subgraph.edges(stuggi,E(stuggi)[weight >= 2])
st2 <- subgraph.edges(stuggi,E(stuggi)[weight <=1])

coords <- layout_with_kk(st1)*2
coords2 <- layout_with_kk(st2)*2


plot(st1, layout=coords, vertex.label.dist=3,edge.curved=TRUE,vertex.label.cex=0.8, vertex.label.font=2,vertex.label.family = "Gujarati Sangam MN",main="Funding-Startups")

plot(st2, layout=coords2, vertex.label.dist=1.5, edge.curved=TRUE,vertex.label.degree = pi/-2,vertex.label.cex=0.7, vertex.label.font=2,vertex.size=15,vertex.label.family = "Gujarati Sangam MN",main="Beratungs-Startups") 

