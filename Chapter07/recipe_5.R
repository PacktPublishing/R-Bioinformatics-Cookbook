library(plotly)

d <- data.frame(
  x <- seq(1,10, by = 0.5),
  y <- seq(1,10, by = 0.5)
)

z <- matrix(rnorm(length(d$x) * length(d$y) ), nrow = length(d$x), ncol = length(d$y))

plot_ly(d, x = ~x , y = ~y, z = ~z) %>% 
  add_surface()


plot_ly(d, x = ~x , y = ~y, z = ~z) %>% 
  add_surface(
    contours = list(
      z = list(
        show=TRUE,
        usecolormap=TRUE,
        highlightcolor="#ff0000",
        project=list(z=TRUE)
      )
    )
  )

plot_ly(longley, x = ~GNP, y = ~Population, z = ~ Employed,
        marker = list(color = ~GNP )
) %>% 
  add_markers()