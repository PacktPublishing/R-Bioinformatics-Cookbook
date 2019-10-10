library(DESeq2)
library(magrittr)
library(ggplot2)

dds <- readRDS(file.path( getwd(), "datasets", "ch1","modencode_dds.RDS") )
plotCounts(dds, gene="FBgn0000014", intgroup = "stage", returnData = TRUE) %>%
  ggplot() + aes(stage, count) + geom_boxplot(aes(fill=stage)) + scale_y_log10() + theme_bw()


result_df <- results(dds, contrast=c("stage","L2Larvae","L1Larvae"), tidy= TRUE) %>%
  dplyr::mutate(is_significant=padj<0.05)

ggplot(result_df) + aes(baseMean, log2FoldChange) + geom_point(aes(colour=is_significant)) + scale_x_log10() + theme_bw()

ggplot(result_df) + aes(log2FoldChange, -1 * log10(pvalue))  + geom_point(aes(colour=is_significant)) + theme_bw()

