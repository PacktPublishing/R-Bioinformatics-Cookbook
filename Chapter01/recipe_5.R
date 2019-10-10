library(Rsamtools)
library(bumphunter)

pileup_df <- Rsamtools::pileup(file.path(getwd(), "datasets", "ch1", "windows.bam"))
clusters <- bumphunter::clusterMaker(pileup_df$seqnames, pileup_df$pos, maxGap = 100) 
table(clusters)

bumphunter::regionFinder(pileup_df$count, pileup_df$seqnames, pileup_df$pos, clusters, cutoff=1)