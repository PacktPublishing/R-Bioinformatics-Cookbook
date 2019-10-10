library(ape)
#get all subtrees
newick <-read.tree(file.path(getwd(), "datasets", "ch4", "mammal_tree.nwk"))
l <- subtrees(newick)

plot(newick)
plot(l[[4]], sub = "Node 4")

# pick subtree graphically
#subtreeplot(newick)

#extract a tree manually
small_tree <- extract.clade(newick, 9)

new_tree <- bind.tree(newick, small_tree, 3)
plot(new_tree)