library(dada2)
library(cowplot)

working_dir <- file.path(getwd(), "datasets", "ch5", "fq")
read_files <- list.files(working_dir, full.names = TRUE,  pattern = "fq.gz")

quality_plots <- lapply(read_files, plotQualityProfile)
plot_grid(plotlist = quality_plots)

for (fq in read_files ){
  out_fq <- paste0(fq, ".trimmed.filtered")
  fastqFilter(fq, out_fq, trimLeft=10, truncLen=250,
              maxN=0, maxEE=2, truncQ=2,
              compress=TRUE)
}

trimmed_files <-  list.files(working_dir, full.names = TRUE, pattern = "trimmed.filtered")
derep_reads <- derepFastq(trimmed_files)

dd_model <- dada(derep_reads[1:5], err=NULL, selfConsist=TRUE)

dada_all <- dada(derep_reads, err=dd_model[[1]]$err_out, pool=TRUE)

plotErrors(dada_all)

sequence_tb <-makeSequenceTable( dada_all )
taxonomy_tb <- assignTaxonomy(sequence_tb, refFasta = file.path(getwd(), "datasets", "ch5", "rdp_train_set_14.fa")) ##train set from http://benjjneb.github.io/dada2/rdp_train_set_14.fa.gz.  and https://purl.stanford.edu/wh250nn9648
taxonomy_tb[1, 1:6]