library(biomaRt)
listMarts(host = "ensembl.gramene.org")


gramene_connection <- useMart(biomart = "ENSEMBL_MART_PLANT_SNP", host = "ensembl.gramene.org")

data_sets <- listDatasets(gramene_connection)

data_set_connection <- useMart("athaliana_eg_snp", biomart = "ENSEMBL_MART_PLANT_SNP", host = "ensembl.gramene.org")
listAttributes(data_set_connection)
listFilters(data_set_connection)

snps <- getBM(attributes = c("refsnp_id", "chr_name", "chrom_start", "chrom_end"), filters = c("chromosomal_region"), values = c("1:200:200000:1"),  mart = data_set_connection )

## There's More
data_set_connection <- useMart("hsapiens_snp", biomart = "ENSEMBL_MART_SNP")
human_snps <- getBM(attributes = c("refsnp_id", "allele", "minor_allele", "minor_allele_freq"), filters = c("chromosomal_region"), value = c("1:200:20000:1"), mart = data_set_connection)