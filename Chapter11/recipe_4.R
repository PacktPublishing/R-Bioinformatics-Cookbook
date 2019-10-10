source(file.path(getwd(), "datasets", "ch11", "my_source_file.R"))
my_sourced_function()

# create new package in current directory
usethis::create_package("newpackage")


## add code in to R/ folder eg. my_source_file.R
my_package_function <- function(x){
  return( c("I come from a package!") )
}

##load package to check code works
devtools::load_all()

## When ready install locally
devtools::install()

library(newpackage)