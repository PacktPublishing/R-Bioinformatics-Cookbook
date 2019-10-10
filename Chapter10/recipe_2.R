library(tidyr)
library(dplyr)
library(purrr)
library(magrittr)
library(ggplot2)


nested_mt <- nest(mtcars, -cyl)
nested_mt

nested_mt_list_cols <- nested_mt %>% mutate(
  model = map(data, ~ lm(mpg ~ wt, data = .x))
)


nested_mt_list_cols <- nested_mt_list_cols %>% mutate(
  tidy_model = map(model, tidy)
)
nested_mt_list_cols

unnest(nested_mt_list_cols, tidy_model)

models_df <- nest(mtcars, -cyl) %>%
  mutate(
    model = map(data, ~ lm(mpg ~ wt, data = .x)),
    tidy_model = map(model, tidy)
  ) %>%
  unnest(tidy_model)



custom_function <- function(x){
  log(mean(x$price, na.rm = TRUE ))
}

summary_function <- function(x){
  x
}


diamonds %>%
  group_by(cut, color) %>%
  nest() %>%
  mutate(
    log_mean = map(data, custom_function)
  ) %>%
  transmute(cut,color, log_mean = map_dbl(log_mean, summary_function))
