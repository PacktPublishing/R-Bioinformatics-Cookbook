library(ape)
newick <-ape::read.tree(file.path(getwd(), "datasets", "ch4", "mammal_tree.nwk"))
nexus <-ape::read.nexus(file.path(getwd(), "datasets", "ch4", "mammal_tree.nexus"))


library(treeio)
beast <- read.beast(file.path(getwd(), "datasets", "ch4", "beast_mcc.tree"))
raxml <- read.raxml(file.path(getwd(), "datasets", "ch4", "RAxML_bipartitionsBranchLabels.H3"))

class(newick)
class(nexus)
class(beast)
class(raxml)

beast_phylo <- treeio::as.phylo(beast)
newick_tidytree <- treeio::as.treedata(newick)


treeio::write.beast(newick_tidytree,file = "mammal_tree.beast")
ape::write.nexus(beast_phylo, file = "beast_mcc.nexus")