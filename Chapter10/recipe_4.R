library(SummarizedExperiment)

#Create new class extending existing one
setClass("BarcodedSummarizedExperiment",
         contains = "SummarizedExperiment",
         slots = c(barcode_id = "character", barcode_sequence = "character")
)

# create constructor
BarcodedSummarizedExperiment <- function(assays, rowRanges, colData, barcode_id, barcode_sequence){
  new("BarcodedSummarizedExperiment", 
      SummarizedExperiment(assays=assays, rowRanges=rowRanges, colData=colData),
      barcode_id = barcode_id,
      barcode_sequence = barcode_sequence
  )
  
}

#add methods
setGeneric("barcode_id", function(x) standardGeneric("barcode_id"))
setMethod("barcode_id", "BarcodedSummarizedExperiment", function(x) x@barcode_id )

## Build data to populate the object
nrows <- 200
ncols <- 6
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows)
assays <- list(counts = counts)
rowRanges <- GRanges(rep(c("chr1", "chr2"), c(50, 150)),
                     IRanges(floor(runif(200, 1e5, 1e6)), width=100),
                     strand=sample(c("+", "-"), 200, TRUE),
                     feature_id=sprintf("ID%03d", 1:200))
colData <- DataFrame(Treatment=rep(c("ChIP", "Input"), 3),
                     row.names=LETTERS[1:6])


my_new_barcoded_experiment <- BarcodedSummarizedExperiment(assays = assays, rowRanges = rowRanges, colData = colData, barcode_id = letters[1:6], barcode_sequence = c("AT", "GC", "TA", "CG","GA", "TC") )

barcode_id(my_new_barcoded_experiment)