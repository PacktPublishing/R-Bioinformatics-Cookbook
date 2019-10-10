library(circlize)

df <- readr::read_tsv("datasets/ch7/arabidopsis.gff", col_names = FALSE) %>% 
  dplyr::select(X1, X4, X5)
circos.genomicInitialize(df)
circos.link("Chr4", c(9000000, 1200000), 
            "Chr5", c(12000000,15000000),
            col = "red")
circos.clear()



source_links <- read.delim("datasets/ch7/arabidopsis_out_links.bed", header = FALSE) 
target_links <- read.delim("datasets/ch7/arabidopsis_in_links.bed", header = FALSE)

circos.genomicInitialize(df)
circos.genomicLink(source_links, target_links, col = "blue")
circos.clear()

gene_positions <- read.delim("datasets/ch7/arabidopsis_genes.bed", header = FALSE)
circos.genomicInitialize(df)
circos.genomicDensity(gene_positions, window.size = 1e6, col = "#0000FF80", track.height = 0.1)
circos.clear()


heatmap_data <- read.delim("datasets/ch7/arabidopsis_quant_data.bed", header = FALSE)
col_fun = colorRamp2(c(10, 12, 15), c("green", "black", "red"))

circos.genomicInitialize(df)
circos.genomicHeatmap(heatmap_data, col = col_fun, side = "inside", border = "white")
circos.clear()


##THere's more

# Make links match lowest track by putting them last
circos.genomicInitialize(df)
circos.genomicHeatmap(heatmap_data, col = col_fun, side = "inside", border = "white")
circos.genomicDensity(gene_positions, window.size = 1e6, col = "#0000FF80", track.height = 0.1)
circos.genomicLink(source_links, target_links, col = "blue")
circos.clear()
