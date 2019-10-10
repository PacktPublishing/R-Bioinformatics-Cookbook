library(ggraph)
library(magrittr)
df <- readr::read_delim(file.path(getwd(), "datasets", "ch7", "bio-DM-LC.edges"), delim = " ", col_names = c("nodeA", "nodeB", "weight")) %>% dplyr::mutate(edge_type = sample(LETTERS[1:2], length(weight), replace = TRUE))

graph <- igraph::graph_from_data_frame(df)

ggraph(graph, layout = "kk") + 
  geom_edge_link() + 
  geom_node_point() + 
  theme_void()


ggraph(graph, layout = "fr") + 
  geom_edge_link(aes(colour = edge_type)) + 
  geom_node_point() + 
  theme_void()

##add node attributes straight to graph object

igraph::V(graph)$category <- sample(c("Nucleus", "Mitochondrion", "Cytoplasm"), length(igraph::V(graph)), replace = TRUE )

igraph::V(graph)$degree <- igraph::degree(graph)

ggraph(graph, layout = "fr") + 
  geom_edge_link(aes(colour = edge_type)) + 
  geom_node_point(aes(size = degree, colour = category)) + 
  theme_void()


ggraph(graph, 'hive', axis = 'category') +
  geom_edge_hive(aes(colour = edge_type, alpha = ..index..)) + 
  geom_axis_hive(aes(colour = category)) + 
  theme_void()

ggraph(graph, 'hive', axis = 'category', sort.by = 'degree') +
  geom_edge_hive(aes(colour = edge_type)) + 
  geom_axis_hive(aes(colour = category)) + 
  theme_void()
