library(e1071)
train_rows <- sample(nrow(iris), 0.8 * nrow(iris), replace = FALSE)

train_set <- iris[train_rows, ]
test_set <- iris[-train_rows, ]

model <- svm(Species~., data=train_set, type="C-classification", kernel="radial", gamma=0.25)
model

cols_to_hold <- c("Sepal.Length", "Sepal.Width")
held_constant <- lapply(cols_to_hold, function(x){mean(train_set[[x]])})
names(held_constant) <- cols_to_hold

plot(model, train_set, Petal.Width ~ Petal.Length, slice = held_constant)

test_set_predictions <- predict(model, test_set, type = "class")
caret::confusionMatrix(test_set_predictions,  test_set$Species)
