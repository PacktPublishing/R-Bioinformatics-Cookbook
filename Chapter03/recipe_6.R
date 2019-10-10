library(kebabs)
library(Biostrings)

seqs <- readAAStringSet(file.path(getwd(), "datasets", "ch3", "ecoli_proteins.fa"))
classes <- readr::read_csv(file.path(getwd(), "datasets", "ch3", "ecoli_protein_classes.txt"), col_names = TRUE)
classes <- classes$class


num_seqs <- length(seqs)

training_proportion <- 0.75
training_set_indices <- sample(1:num_seqs, training_proportion * num_seqs)
test_set_indices <- c(1:num_seqs)[-training_set_indices]

kernel <- gappyPairKernel(k=1, m=3)

model <- kbsvm(x=seqs[training_set_indices], y=classes[training_set_indices], kernel=kernel, pkg="e1071", svm="C-svc", cost=15)

predictions <- predict(model, seqs[test_set_indices])
evaluatePrediction(predictions, classes[test_set_indices], allLabels=c(1,-1) )


##predict sites in sequence 

seq_to_test <- seqs[[1]][1:10]
seq_to_test

prediction_profile <-getPredictionProfile(seq_to_test, kernel, featureWeights(model), modelOffset(model) )
plot(prediction_profile)