library(Biostrings)
library(msa)
library(phangorn)

seqs <- readAAStringSet(file.path(getwd(), "datasets", "ch4", "abc.fa"))
aln <- msa::msa(seqs, method=c("ClustalOmega"))
aln <- as.phyDat(aln, type = "AA")


dist_mat <- dist.ml(aln)

upgma_tree <- upgma(dist_mat)
plot(upgma_tree, main="UPGMA")

nj_tree <- NJ(dist_mat)
plot(nj_tree,"unrooted", main="NJ")


fit <- pml(nj_tree, aln)
bootstraps <- bootstrap.phyDat(aln,FUN=function(x) { NJ(dist.ml(x)) } , bs=100)
plotBS(nj_tree, bootstraps, p = 10)
