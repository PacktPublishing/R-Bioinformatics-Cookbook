library(bio3d)
a <- read.pdb(file.path(getwd(), "datasets", "ch3" ,"1xwc.pdb"))
b <- read.pdb(file.path(getwd(), "datasets", "ch3", "3trx.pdb"))

pdbs <- pdbaln(list("1xwc"=a,"3trx"=b), fit=TRUE,exefile="msa")
pymol(pdbs, exefile = "/Users/macleand/miniconda2/bin/pymol", type = "launch", as="cartoon")