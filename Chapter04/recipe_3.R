library(ape)
library(adegraphics)
library(treespace)
treefiles <- list.files(file.path(getwd(), "datasets", "ch4", "gene_trees"),full.names = TRUE)
tree_list <- lapply(treefiles, read.tree)
class(tree_list) <- "multiPhylo"

comparisons <- treespace(tree_list, nf = 3)
adegraphics::table.image(comparisons$D, nclass=25)

plotGroves(comparisons$pco, lab.show=TRUE, lab.cex=1.5)

groves <- findGroves(comparisons, nclust = 4)
plotGroves(groves)