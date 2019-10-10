## Recipe 1 - Estimating differential expression with edgeR

## Count table

### Load data
count_dataframe <- readr::read_tsv(file.path(getwd(), "datasets", "ch1", "modencodefly_count_table.txt" ))
genes <- count_dataframe[['gene']]
count_dataframe[['gene']] <- NULL
count_matrix <- as.matrix(count_dataframe)
rownames(count_matrix) <- genes
pheno_data <- readr::read_table2(file.path(getwd(), "datasets", "ch1", "modencodefly_phenodata.txt"))


### Specify experiments of interest 

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which( pheno_data[['stage']] %in% experiments_of_interest ) #gives the numeric indices of the above experiments in the matrix

### Form grouping factor
library(magrittr)
grouping <- pheno_data[['stage']][columns_of_interest] %>% 
  forcats::as_factor()

### Form subset count data
counts_of_interest <-  count_matrix[,columns_of_interest]

### Form DGE
library(edgeR)
count_dge <- edgeR::DGEList(counts = counts_of_interest, group = grouping)


### Perform differential expression 
design <- model.matrix(~ grouping)
eset_dge <- edgeR::estimateDisp(eset_dge, design)
fit <- edgeR::glmQLFit(eset_dge, design)
result <- edgeR::glmQLFTest(fit, coef=2)
topTags(result)


##eset
load(file.path(getwd(), "datasets/ch1/modencodefly_eset.RData"))

experiments_of_interest <- c("L1Larvae", "L2Larvae")
columns_of_interest <- which( phenoData(modencodefly.eset)[['stage']] %in% experiments_of_interest )

grouping <- droplevels(phenoData(modencodefly.eset)[['stage']][columns_of_interest] )

counts_of_interest <- exprs(modencodefly.eset)[, columns_of_interest]

eset_dge <- edgeR::DGEList(
  counts = counts_of_interest,
  group = grouping 
  )

design <- model.matrix(~ grouping)
eset_dge <- edgeR::estimateDisp(eset_dge, design)
fit <- edgeR::glmQLFit(eset_dge, design)
result <- edgeR::glmQLFTest(fit, coef=2)
topTags(result)