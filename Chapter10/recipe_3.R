return_single_value <- function(x){
  sum(x)  
}

return_length_values <- function(x){
  paste0("result_", 1:length(x))
}

return_three_values <- function(x){
  c("A", "b", "C")
}

iris %>% mutate(
  result = return_single_value(Petal.Length)
)

iris %>% mutate(
  result = return_length_values(Petal.Length)
)


#fails
#iris %>% mutate(
#  result = return_three_values(Petal.Length)
#)

rep_until <- function(x){
  rep(c("A", "b", "C"), length.out = length(x))
}

iris %>% mutate(
  result = rep_until(Petal.Length)
)