library(MSnID)
library(data.table)
library(dplyr)
library(ggplot2)

msnid <- MSnID() # create object
msnid <- read_mzIDs(msnid, file.path(getwd(), "datasets", "ch6", "HeLa_180123_m43_r2_CAM.mzid.gz")) # load result into object ! 
peptide_info <- as(msnid, "data.table") 
#colnames(peptide_info)

## summarise and check the distribution

# remove decoys and calculalte times each peptide seen
# sample variable added to allow ggplot formula to work in plots
per_peptide_counts <- peptide_info %>% 
  filter(isDecoy == FALSE) %>%
  group_by(pepSeq) %>%
  summarise(count = n() ) %>% 
  mutate(sample = rep("peptide_counts", length(counts) ) )

# plot distribution of each time peptide seen on log scale
per_peptide_counts %>% 
  ggplot() + aes( sample, count)  + geom_jitter() + geom_violin() + scale_y_log10()

# get a cumulative plot of counts, peptide variable used as a plotting index
per_peptide_counts %>%
  arrange(count) %>%
  mutate(cumulative_hits = cumsum(count), peptide = 1:length(count))  %>%
  ggplot() + aes(peptide, cumulative_hits) + geom_line()

# filter out lowest and highest hits
filtered_per_peptide_counts <- per_peptide_counts %>%
  filter(count >= 5, count <= 2500) 

#plot
filtered_per_peptide_counts %>% 
  ggplot() + aes( sample, count)  + geom_jitter() + geom_violin() + scale_y_log10()

#plot as density to make skew of distribution clear
filtered_per_peptide_counts %>%
  ggplot() + aes(count) + geom_density() + scale_x_log10()