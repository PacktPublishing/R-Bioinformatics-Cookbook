## Setup package for sharing by adding a license, a readme, a badge and a new version
usethis::use_mit_license(name = "Dan MacLean")
usethis::use_readme_rmd()
usethis::use_lifecycle_badge("Experimental")
usethis::use_version()

## Add dependencies
usethis::use_package("ggplot2")

## setup the local git repository
usethis::use_git()

usethis::browse_github_token() # gives info on how to setup github auth
usethis::use_github()

##manually push to github ...
# GitHub: https://github.com/new. 
# git remote add origin git@github.com:user/repo
# git push -u origin master

# git commit needed later

## pull package from github.
devtools::install_github("user/repo")
