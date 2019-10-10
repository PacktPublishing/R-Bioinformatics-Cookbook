library(vegan)
biom_file <- file.path(getwd(), "datasets", "ch5", "rich_high_count_otu.biom")
taxdata <- metacoder::parse_qiime_biom(biom_file)
otu_table <- taxdata$data$otu_table[, paste0("Sample", 1:6)]

alpha_diversity <- diversity(otu_table, MARGIN=2, index="simpson")
barplot(alpha_diversity)

between_sample <- vegdist(t(otu_table), index = "bray")
between_sample_m <- as.matrix(between_sample, ncol = 6)

corrplot::corrplot(between_sample_m, method="circle", type = "upper", diag = FALSE )
