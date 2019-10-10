library(metacoder)
library(RColorBrewer)

biom_file <- file.path(getwd(), "datasets", "ch5", "rich_high_count_otu.biom")
taxdata <- parse_qiime_biom(biom_file)
heat_tree(taxdata, node_label = taxon_names, node_size = n_obs, node_color = n_supertaxa, layout = "gem", title = "sample heat tree", node_color_axis_label = "Number of Supertaxa", node_size_axis_label = "Number of OTUs", node_color_range = brewer.pal(5, "Greens"))