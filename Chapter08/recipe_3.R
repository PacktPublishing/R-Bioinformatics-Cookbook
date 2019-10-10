ensembl_connection <- useMart(biomart = "ENSEMBL_MART_ENSEMBL")
listDatasets(ensembl_connection)

data_set_connection <- useMart("hsapiens_gene_ensembl", biomart = "ENSEMBL_MART_ENSEMBL")

att <- listAttributes(data_set_connection)
fil <- listFilters(data_set_connection)

genes <- getBM(attributes = c("ensembl_gene_id"), filters = c("chromosomal_region"), value = c("1:200:2000000:1"), mart = data_set_connection)

go_ids <- getBM(attributes = c("go_id", "goslim_goa_description"), filters = c("ensembl_gene_id"), values = genes$ensembl_gene_id, mart = data_set_connection )

