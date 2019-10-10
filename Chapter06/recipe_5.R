library(mzR)
library(protViz)
mzml_file <-  file.path(getwd(), "datasets", "ch6", "MM8.mzML")
ms <- openMSfile(mzml_file)

p <- peaks(ms,2)

spec <- list(mZ = p[,1], intensity = p[,2])

m <- psm("PEPTIDESEQ", spec, plot=TRUE)
