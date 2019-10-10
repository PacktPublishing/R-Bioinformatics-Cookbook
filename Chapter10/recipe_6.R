m <- matrix(rep(1:10, 10, replace = TRUE), nrow = 10)
m

apply(m, 1, sum)
apply(m, 2, sum)


variance <- function(x){ sd(x) ^ 2 }
apply(m, 2, variance)


numbers <- 1:3
number_of_numbers <- function(x){
  rnorm(x)
}

#over vector
my_list <- lapply(numbers, number_of_numbers)
my_list

summary_function <- function(x){
  mean(x)
}

#over list
lapply(my_list, summary_function)

sapply(my_list, summary_function)

#over dataframe columns
list_from_data_frame <- lapply(iris, mean, trim = 0.1, na.rm = TRUE )
list_from_data_frame
unlist(list_from_data_frame)