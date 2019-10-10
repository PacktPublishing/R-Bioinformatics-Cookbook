library(class)
library(magrittr)
library(dplyr)
library(caret)
set.seed(123)

scaled_iris <- iris %>% mutate_if( is.numeric, .funs = scale)
train_rows <- sample(nrow(scaled_iris), 0.8 * nrow(scaled_iris), replace = FALSE)

labels <- scaled_iris$Species
scaled_iris$Species <- NULL

train_set <- scaled_iris[train_rows, ]
test_set <- scaled_iris[-train_rows, ]
train_labels <- labels[train_rows]
test_set_labels <- labels[-train_rows]

#builds model on train set does predictions on test set, you add different test set everytime
test_set_predictions <- knn(train = train_set, test = test_set, cl = train_labels, k = 10)
caret::confusionMatrix(test_set_predictions,  test_set_labels)
