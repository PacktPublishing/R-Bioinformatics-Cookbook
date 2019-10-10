library(VariantAnnotation)
library(rrBLUP)
set.seed(1234)

vcf_file <- file.path(getwd(), "datasets", "ch2", "small_sample.vcf")
vcf <- readVcf(vcf_file, "hg19")
gts <- geno(vcf)$GT


samples <- samples(header(vcf))
markers <- rownames(gts)
chrom <- as.character(seqnames(rowRanges(vcf)))
pos <- as.numeric(start(rowRanges(vcf)))

convert <- function(v){
  v <- gsub("0/0", 1, v)
  v <- gsub("0/1", 0, v)
  v <- gsub("1/0", 0, v)
  v <- gsub("1/1",-1, v)
  return(v)
}
gt_char<- apply(gts, convert, MARGIN = 2)

genotype_matrix <- matrix(as.numeric(gt_char), nrow(gt_char) )
colnames(genotype_matrix)<- samples

variant_info <- data.frame(marker = markers,
                           chrom = chrom,
                           pos = pos)

genotypes <-  cbind(variant_info, as.data.frame(genotype_matrix))
genotypes

phenotypes <- data.frame(
  line = samples,
  score = rnorm(length(samples))
)

phenotypes

GWAS(phenotypes, genotypes,plot=FALSE)