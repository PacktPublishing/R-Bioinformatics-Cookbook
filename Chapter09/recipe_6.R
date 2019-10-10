library(factoextra)
library(Biobase)

load(file.path(getwd(), "datasets", "ch1", "modencodefly_eset.RData") ) 

expr_pca <- prcomp(exprs(modencodefly.eset), scale=TRUE, center=TRUE )
fviz_screeplot(expr_pca)

main_components <- expr_pca$rotation[, 1:3] # this means we do columnwise analysis - clustering of samples

fviz_nbclust(main_components, kmeans, method = "wss")
kmean_clus <- kmeans(main_components, 5, nstart=25, iter.max=1000)
kmean_clus$cluster[1:5]

fviz_cluster(kmean_clus, data = main_components,
             palette = RColorBrewer::brewer.pal(5, "Set2"),
             ggtheme = theme_minimal(),
             main = "k-Means Sample Clustering"
)