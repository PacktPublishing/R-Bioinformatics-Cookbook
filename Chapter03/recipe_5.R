library(DECIPHER)
long_seqs <- readDNAStringSet(file.path(getwd(), "datasets", "ch3", "plastid_genomes.fa"))
long_seqs
##make a sequence db on disk
Seqs2DB(long_seqs, "XStringSet", "long_db", names(long_seqs))

## Find Syntenic bloocks
synteny <- FindSynteny("long_db")

##view syntenic blocks
pairs(synteny)
plot(synteny)

##make an actual alignment
alignment <- AlignSynteny(synteny, "long_db")

##Is a structure holding all aligned syntenic blocks for each pair of sequences here genomes 1 and 2
blocks <- unlist(alignment[[1]])

##therefore write one alignment at a time
writeXStringSet(blocks, "genome_blocks_out.fa")
```