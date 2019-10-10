set.seed(1)
random_number_t_test <- function(n){
  x <- rnorm(10)
  y <- rnorm(10)
  return(t.test(x,y)$p.value)
}


p_values <- sapply(1:10000, random_number_t_test )
sum(p_values <= 0.05)

adj_p_values <- p.adjust(p_values, method = "holm")
sum(adj_p_values <= 0.05)