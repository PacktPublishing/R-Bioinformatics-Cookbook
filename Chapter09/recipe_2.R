library(fakeR)
fake_iris <- simulate_dataset(iris) 

sample_mean <- mean(iris$Sepal.Length)
sample_sd <- sd(iris$Sepal.Length)

random_sepal_lengths <- rnorm(iris$Sepal.Length, mean = sample_mean, sd = sample_sd)
hist( random_sepal_lengths) 

#Uniform numbers
low_num <- 1
high_num <- 6
hist(runif(1500, low_num, high_num))

#Binomial numbers
number_of_coins <- 1
p_heads <- 0.5
hist(rbinom(1500, number_of_coins, p_heads ))

number_of_coins <- 5
hist(rbinom(1500, number_of_coins, p_heads ))

## integers in a range with uniform probability
random_integers <- sample(1:100, 10)

#random value from a bag with specified probability
random_from_list <- sample(c("Low", "Medium", "High"), 100, replace = TRUE, prob = c(0.2, 0.6, 0.2))
table(random_from_list)
```