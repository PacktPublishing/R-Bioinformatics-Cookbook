library(mzR)
mzxml_file <- file.path(getwd(), "datasets", "ch6", "threonine_i2_e35_pH_tree.mzXML")
mzdata <- openMSfile(mzxml_file)
header_info <- header(mzdata)
peak_data_list <- spectra(mzdata) #must be a list - if only one spectrum, remember to wrap it in list()
writeMSData(peak_data_list, file.path(getwd(), "datasets", "ch6", "out.mz"), header = header_info, outformat = "mzml", rtime_seconds = TRUE ) #can import mzml mzxml and mzdata and export mzml and mzxml
