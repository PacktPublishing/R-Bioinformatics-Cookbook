library(ensembldb)
library(EnsDb.Rnorvegicus.v79)
## check has proper data
hasProteinData(EnsDb.Rnorvegicus.v79)
listTables(EnsDb.Rnorvegicus.v79) #lloking for column with ipro accession
e <- EnsDb.Rnorvegicus.v79


# get a list of geneids 
k <- head(keys(e, keytype = "GENEID"), n = 3 )
select(e, keys = GeneIdFilter(k),
       columns = c("TXBIOTYPE", "UNIPROTID", "PROTEINID","INTERPROACCESSION"))


##with biomart for non ensembl organisms
library(biomaRt)

biomart_athal <- useMart(biomart = "plants_mart", host = "plants.ensembl.org", dataset = "athaliana_eg_gene")

##use below to view which marts are available, see written notes

#listMarts(host="plants.ensembl.org")
#listDatasets(useMart(biomart="plants_mart",host="plants.ensembl.org"))
#get data from the biomart, first arg is what to retrieve, filters is what to filter on, values is values to filter on mart is connection objet

getBM( c("tair_locus", "interpro"), filters=c("tair_locus"), values = c("AT5G40950", "AT2G40510"), mart = biomart_athal)
