print("Arabidopsis")
library(org.At.tair.db)
columns(org.At.tair.db)

print("E.coli")
library(org.EcK12.eg.db)
columns(org.EcK12.eg.db)

print("Human")
library(org.Hs.eg.db)


##inspect the keytype available - different from columns in that these are the things we can actually use to access
keytypes(org.Hs.eg.db)

##make a vector of keys (here ensembl IDs) to work with, could come from other source, just pick 3 genes
k <- head(keys(org.Hs.eg.db, keytype = "ENSEMBL"), n = 3 )

#select the data and get the annotation
result <- select(org.Hs.eg.db, keys = k, keytype="ENSEMBL", columns = c("PFAM"))
result
## now get the descriptions

library(PFAM.db)

## Get the description object - other mappings are available
descriptions <- PFAMDE
##get all keys IE all PFAM IDs that exist in the database
all_ids <- mappedkeys(descriptions)

#get all the descriptions for the mappings

id_description_mapping <- as.data.frame(descriptions[all_ids])

dplyr::left_join(result, id_description_mapping, by = c("PFAM" = "ac") )

library(bio3d)
sequence <- read.fasta(file.path(getwd(), "datasets", "ch3", "ecoli_hsp.fa") )
# run pfamseq on protein
result <- hmmer(sequence, type="hmmscan", db="pfam")
result$hit.tbl

