library(VariantAnnotation)


is_not_microsat <- function(x){ !grepl("microsat", x, fixed = TRUE)}

prefilters <- FilterRules(list(microsat = is_not_microsat) )

major_alt <- function(x){
  af <- info(x)$AF ## also geno() fixed() 
  result <- unlist(lapply(af, function(x){x[1] < 0.5}))
  return(result)
}
filters <- FilterRules(list(alt_is_major = major_alt))

vcf_file <- file.path(getwd(), "datasets", "ch2", "sample.vcf.gz")
filterVcf(vcf_file, "hg17", "filtered.vcf", prefilters = prefilters, filters = filters)