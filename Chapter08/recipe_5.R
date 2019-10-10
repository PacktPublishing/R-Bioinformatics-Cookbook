library(ShortRead)
fastq_file <- readFastq(file.path(getwd(), "datasets", "ch8", "ERR019652.fastq.gz") )

qualities <- rowSums(as(quality(fastq_file), "matrix") <= 20) 
fastq_file <- fastq_file[qualities == 0] # Number of reads where all Phred scores >= 20

cut_off_txt <- rawToChar(as.raw(40))
trimmed <- trimTails(fastq_file, k =2, a= cut_off_txt)


custom_filter_1 <- nFilter(threshold=0)
custom_filter_2 <- polynFilter(threshold = 10, nuc = c("A", "T", "C", "G"))
custom_filter <- compose(custom_filter_1, custom_filter_2)
passing_rows <- custom_filter(trimmed)
trimmed <- trimmed[passing_rows]

writeFastq(trimmed, file = file.path(getwd(), "datasets", "ch8", "ERR019652.trimmed.fastq.gzip"),  compress = TRUE)