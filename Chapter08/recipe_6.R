bwa <- "/Users/macleand/miniconda2/bin/bwa"
samtools <- "/Users/macleand/miniconda2/bin/samtools"
reference <- file.path(getwd(), "datasets", "ch8", "ecoli_genome.fa")

command <- paste(bwa, "index", reference)
system(command, wait = TRUE)

reads <- file.path(getwd(), "datasets", "ch8", "ERR019653.fastq.gz")

output <- file.path(getwd(), "datasets", "ch8", "aln.bam")

command <- paste(bwa, "mem", reference, reads, "|", samtools, "view -S -b >", output)
system(command, wait = TRUE)