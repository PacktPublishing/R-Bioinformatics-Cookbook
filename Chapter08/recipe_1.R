library(biomaRt)
listMarts(host = "ensembl.gramene.org")


gramene_connection <- useMart(biomart = "ENSEMBL_MART_PLANT", host = "ensembl.gramene.org")

data_sets <- listDatasets(gramene_connection)
head(data_sets)


data_set_connection <- useMart("atrichopoda_eg_gene", biomart = "ENSEMBL_MART_PLANT", host = "ensembl.gramene.org")

attributes <- listAttributes(data_set_connection)
head(attributes)

chrom_names <- getBM(attributes = c("chromosome_name"),  mart = data_set_connection )
head(chrom_names)

filters <- listFilters(data_set_connection)
head(filters)

first_chr <- chrom_names$chromosome_name[1]

genes <- getBM(attributes = c("ensembl_gene_id", "description"), filters = c("chromosome_name"), values = c(first_chr), mart = data_set_connection )

head(genes)
```