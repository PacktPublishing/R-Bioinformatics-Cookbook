library(msa)
seqs <- readAAStringSet(file.path(getwd(), "datasets", "ch3", "hglobin.fa"))
seqs

alignment <- msa(seqs, method = "ClustalOmega")
alignment

msaPrettyPrint(alignment, output="pdf", showNames="left",
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file="whole_align.pdf")

msaPrettyPrint(alignment, c(10,30), output="pdf", showNames="left",
               file = "zoomed_align.pdf", showLogo="top", askForOverwrite=FALSE, verbose=FALSE)

##make atree
library(ape)
library(seqinr)
#convert to seqinr alignment -> get distances, make tree
alignment_seqinr <- msaConvert(alignment, type="seqinr::alignment")
distances <- seqinr::dist.alignment(alignment_seqinr, "identity")
tree <- ape::nj(distances)
plot(tree, main="Phylogenetic Tree of HBA Sequences")