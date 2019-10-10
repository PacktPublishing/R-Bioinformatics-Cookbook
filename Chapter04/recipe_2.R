library(ggplot2)
library(ggtree)

itol <- ape::read.tree(file.path(getwd(), "datasets", "ch4", "itol.nwk")) 
ggtree(itol)

ggtree(itol, layout = "circular")

ggtree(itol) + coord_flip() + scale_x_reverse()


ggtree(itol) + geom_tiplab( color = "blue", size = 2)


ggtree(itol, layout = "circular") + geom_strip(13,14, color="red", barsize = 1)

ggtree(itol, layout = "unrooted") + geom_hilight_encircle(node = 11, fill = "steelblue")



MRCA(itol, tip=c("Photorhabdus_luminescens", "Blochmannia_floridanus"))