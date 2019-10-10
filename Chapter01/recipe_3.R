
install.packages("devtools")
devtools::install_github("bvieth/powsimR")

arab_data <- readRDS(file.path(getwd(), "datasets", "ch1", "arabidopsis.RDS" ))
means_mock <- rowMeans(arab_data[, c("mock1", "mock2", "mock3")])
means_hrcc <- rowMeans(arab_data[, c("hrcc1", "hrcc2", "hrcc3")])
log2fc <- log2(means_hrcc / means_mock)

prop_de <- sum(abs(log2fc) > 2) / length(log2fc) 
prop_de


finite_log2fc <-log2fc[is.finite(log2fc)]
plot(density(finite_log2fc))
extRemes::qqnorm(finite_log2fc )

library(powsimR)
library(dplyr)

  params <- estimateParam(
    countData = arab_data,
    Distribution = "NB",
    RNAseq = "bulk",
    normalisation = "TMM" # edgeR method, can be others
  )
  
  de_opts <- DESetup(ngenes=1000,
                     nsims=25,
                     p.DE = prop_de,
                     pLFC= finite_log2fc,
                     sim.seed = 58673
  )

  sim_opts <- SimSetup(
    desetup = de_opts,
    params = params
  )
  
  num_replicates <- c(2, 3, 5, 8, 12,15)
  simDE <- simulateDE(n1 = num_replicates,
                      n2 = num_replicates,
                      sim.settings = sim_opts,
                      DEmethod = "edgeR-LRT",
                      normalisation = "TMM",
                      verbose = FALSE)


   evalDE <- evaluateDE(simRes = simDE,
                                 alpha.type = 'adjusted',
                                 MTC = 'BH',
                                 alpha.nominal = 0.1,
                                 stratify.by = 'mean',
                                 filter.by = 'none',
                                 strata.filtered = 1,
                                 target.by = 'lfc',
                                 delta = 0)


  plotEvalDE(evalRes = evalDE,
                    rate='marginal',
                    quick=FALSE, annot=TRUE)


log2fc_func <- function(x){ rnorm(x, 0, 2)} 
prop_de = 0.1

de_opts <- DESetup(ngenes=1000,
                     nsims=25,
                     p.DE = prop_de,
                     pLFC= log2fc_func,
                     sim.seed = 58673
  )

