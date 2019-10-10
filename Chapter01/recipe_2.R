
count_dataframe <- readr::read_tsv(file.path(getwd(), "datasets", "ch1", "modencodefly_count_table.txt" ))

genes <- count_dataframe[['gene']]
count_dataframe[['gene']] <- NULL

count_matrix <- as.matrix(count_dataframe)
rownames(count_matrix) <- genes


pheno_data <- readr::read_table2(file.path(getwd(), "datasets", "ch1", "modencodefly_phenodata.txt"))

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which( pheno_data[['stage']] %in% experiments_of_interest ) #gives the numeric indices of the above experiments in the matrix

grouping <- pheno_data %>% 
  dplyr::filter(stage %in% experiments_of_interest )

counts_of_interest <-  count_matrix[,columns_of_interest]


library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = counts_of_interest,
                              colData = grouping,
                              design = ~ stage)


dds <- DESeq(dds)
res <- results(dds, contrast=c("stage","L2Larvae","L1Larvae"))



library(SummarizedExperiment)
load(file.path(getwd(), "datasets/ch1/modencodefly_eset.RData"))
summ_exp <- makeSummarizedExperimentFromExpressionSet(modencodefly.eset)
ddsSE <- DESeqDataSet(summ_exp, design= ~ stage)

ddsSE <- DESeq(ddsSE)
resSE <- results(ddsSE, contrast=c("stage","L2Larvae","L1Larvae"))
