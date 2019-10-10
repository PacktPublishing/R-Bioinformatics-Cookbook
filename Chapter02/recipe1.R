library(GenomicRanges)
library(gmapR)
library(rtracklayer)
library(VariantAnnotation)
library(VariantTools)


bam_folder <- file.path(getwd(), "datasets", "ch2")
bam_file <- file.path( bam_folder, "hg17_snps.bam")

fasta_file <- file.path(bam_folder,"chr17.83k.fa")
fa <- rtracklayer::FastaFile(fasta_file)

genome <- gmapR::GmapGenome(fa, create=TRUE)


qual_params <- TallyVariantsParam(
  genome = genome,
  minimum_mapq = 20)


var_params <- VariantCallingFilters(read.count = 19,
                                    p.lower = 0.01
)

called_variants <- callVariants(bam_file, 
                                qual_params, 
                                calling.filters = var_params
)

head(called_variants)

VariantAnnotation::sampleNames(called_variants) <- "sample_name"
vcf <- VariantAnnotation::asVCF(called_variants)
VariantAnnotation::writeVcf(vcf, "hg17.vcf")

get_annotated_regions_from_gff <- function(file_name) {
  gff <- rtracklayer::import.gff(file_name) 
  as(gff, "GRanges")
}

get_annotated_regions_from_bed <- function(file_name){
  bed <- rtracklayer::import.bed(file_name)
  as(bed, "GRanges")
}

genes <- get_annotated_regions_from_gff(file.path( bam_folder, "chr17.83k.gff3"))

overlaps <- GenomicRanges::findOverlaps(called_variants, genes)
overlaps
genes[subjectHits(overlaps)]