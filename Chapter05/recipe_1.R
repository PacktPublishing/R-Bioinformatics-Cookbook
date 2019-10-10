library(phyloseq)

##hdf5
biom_file <- file.path(getwd(), "datasets", "ch5", "rich_sparse_otu_table.biom")
qiime <- import_biom(biom_file)

tax_table(qiime)
otu_table(qiime)
sample_data(qiime)


mothur <- import_mothur(
  mothur_list_file = file.path(getwd(), "datasets", "ch5", "esophagus.fn.list"),
  mothur_group_file = file.path(getwd(), "datasets", "ch5", "esophagus.good.groups"),
  mothur_tree_file = file.path(getwd(), "datasets", "ch5", "esophagus.tree")
)
otu_table(mothur)