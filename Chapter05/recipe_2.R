library(metacoder)

biom_file <- file.path(getwd(), "datasets", "ch5", "rich_high_count_otu.biom")
taxdata <- parse_qiime_biom(biom_file)


sample_ids <- paste0("Sample", 1:6)
taxdata$data$otu_table

hist_data <- colSums(taxdata$data$otu_table[, sample_ids])
hist(hist_data, prob= TRUE, breaks=3)
lines(density(hist_data, adjust = 2), col="red")

taxdata$data$rarefied_otus <- rarefy_obs(taxdata, "otu_table", other_cols = TRUE)

low_otu_index <- rowSums(taxdata$data$rarefied_otus[, sample_ids]) <=20
low_otu_index

taxdata <- filter_obs(taxdata, "rarefied_otus", ! low_otu_index)
taxdata$data$rarefied_otus


#There's more
library(vegan)
rotated_otu_table <- t(taxdata$data$otu_table[,sample_ids])
rarecurve(rotated_otu_table, sample = min(colSums(taxdata$data$otu_table[,sample_ids])))

