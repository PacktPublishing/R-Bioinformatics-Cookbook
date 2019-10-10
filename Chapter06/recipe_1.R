library(mzR)
#mzXML
mzxml_file <- file.path(getwd(), "datasets", "ch6", "threonine_i2_e35_pH_tree.mzXML")
ms1 <- openMSfile(mzxml_file)
class(ms1)
#mzData
mzdata_file <- file.path(getwd(), "datasets", "ch6", "HAM004_641fE_14-11-07--Exp1.extracted.mzdata")
ms2 <- openMSfile(mzdata_file)
class(ms2)
#mzML
mzml_file <-  file.path(getwd(), "datasets", "ch6", "MM8.mzML")
ms3 <- openMSfile(mzml_file)

#view some metadata
runInfo(ms3)
sampleInfo(ms1)


library(MSnbase)
msn_exp <- readMSData(mzxml_file)

plot(msn_exp, full = TRUE)

plot(msn_exp[5], full = TRUE)