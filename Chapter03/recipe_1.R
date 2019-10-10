library(universalmotif)
library(Biostrings)



motif <- read_matrix(file.path(getwd(), "datasets", "ch3","simple_motif.txt"))
view_motifs(motif)

sequences <- readDNAStringSet(file.path(getwd(), "datasets", "ch3", "promoters.fa"))

motif_hits <- scan_sequences(motif, sequences = sequences)
head(motif_hits)

motif_info <- enrich_motifs(motif, sequences, shuffle.k = 3, verbose = 0, progress = FALSE, RC = TRUE)
motif_info

meme_path = "/SET/TO/YOUR/MEME/PATH"
meme_run <- run_meme(sequences, bin = meme_path, output = "meme_out", overwrite.dir = TRUE)

motifs <- read_meme("meme_out/meme.txt")
view_motifs(motifs)