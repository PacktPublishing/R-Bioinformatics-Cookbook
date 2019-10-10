library(sva)

arab <- readRDS(file.path(getwd(), "datasets", "ch1", "arabidopsis.RDS"))

keep <- apply(arab, 1, function(x) { length(x[x>3])>=2 } )
arab_filtered <- arab[keep,]

groups <- as.factor(rep(c("mock", "hrcc"), each=3))

test_model <- model.matrix(~groups)
null_model <- test_model[,1]

svar <- svaseq(arab_filtered, test_model, null_model, n.sv=1)
design <- cbind(test_model, svar$sv)