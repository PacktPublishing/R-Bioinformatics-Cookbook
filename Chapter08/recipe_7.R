library(ramwas)

param <- ramwasParameters( dirbam = ".", filebamlist = "bam_list.txt", dirproject = "datasets/ch8", filebam2sample = "sample_list.txt")
ramwas1scanBams(param)

qc <- readRDS("datasets/ch8/rds_qc/ERR019652.small.qc.rds")$qc
plot(qc$hist.score1)
plot(qc$bf.hist.score1)
plot(qc$hist.length.matched)
plot(qc$bf.hist.length.matched)