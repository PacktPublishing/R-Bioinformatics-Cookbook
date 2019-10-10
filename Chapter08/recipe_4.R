library(SRAdb)
sqlfile <- file.path(system.file('extdata', package='SRAdb'), 'SRAmetadb_demo.sqlite')
## Real file from SRA is > 40Gb! 


sra_con <- dbConnect(SQLite(),sqlfile)

study_info <- dbGetQuery(sra_con, "select study_accession, study_description from study where study_description like '%coli%' ")

sraConvert( c('ERP000350'), sra_con = sra_con )

listSRAfile( c("ERR019652","ERR019653"), sra_con, fileType = 'sra' )

getSRAfile( c("ERR019652","ERR019653"), sra_con, fileType = 'fastq', destDir = file.path(getwd(), "datasets", "ch8") )
