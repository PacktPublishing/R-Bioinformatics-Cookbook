library(csaw)

whole_genome <- csaw::windowCounts( 
  file.path(getwd(), "datasets", "ch2", "hg17_snps.bam"),
  bin = TRUE,
  filter = 0,
  width = 100,
  param = csaw::readParam(
    minq = 20,
    dedup = TRUE,
    pe = "both"
  )
)
colnames(whole_genome) <- c("h17")

counts <- assay(whole_genome)[,1]
min_count <- quantile(counts, 0.1)[[1]]
counts[counts < min_count] <- NA
n <- length(counts)

doubled_windows <- 10

left_pad <- floor( (n/2) - doubled_windows )
right_pad <- n - left_pad -doubled_windows
multiplier <- c(rep(1, left_pad ), rep(2,doubled_windows), rep(1, right_pad) )
counts <- counts * multiplier

mean_cov <- mean(counts, na.rm=TRUE) 

ratio <- matrix(log2(counts / mean_cov), ncol = 1)
plot(ratio)

se <- SummarizedExperiment(assays=list(ratio), rowRanges= rowRanges(whole_genome), colData = c("CoverageRatio"))

region_of_interest <- GRanges(
  seqnames = c("NC_000017.10"),
  IRanges(c(40700), width = c(1500) )
)

overlap_hits <- findOverlaps(region_of_interest, se)
data_in_region <- se[subjectHits(overlap_hits)]
assay(data_in_region)