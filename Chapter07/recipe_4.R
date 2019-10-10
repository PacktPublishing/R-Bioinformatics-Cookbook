library(plotly)

plot_ly(data = Orange, x = ~age, y = ~circumference)

plot_ly(data = Orange, x = ~age, y = ~ circumference,
        color = ~Tree, size = ~age,
        text = ~paste("Tree ID: ", Tree, "<br>Age: ", age, "Circ: ", circumference)
)

trace_1 <- rnorm(35, mean = 120, sd = 10)
new_data <- data.frame(Orange, trace_1)

plot_ly(data = new_data, x = ~age, y = ~ circumference,
        color = ~Tree, size = ~age,
        text = ~paste("Tree ID: ", Tree, "<br>Age: ", age, "Circ: ", circumference)
        
)  %>% add_trace(y = ~trace_1, mode = 'lines' ) %>%
  add_trace(y = ~circumference, mode = 'markers' )



plot_ly(data = Orange, x = ~age, y = ~ circumference,
        color = ~Tree, size = ~age,
        text = ~paste("Tree ID: ", Tree, "<br>Age: ", age, "Circ: ", circumference)
        
)  %>%
  add_trace(y = ~circumference, mode = 'marker' ) %>%
  layout(
    title = "Plot with switchable trace",
    updatemenus = list(
      list(
        type = "dropdown",
        y = 0.8,
        buttons = list(
          list(method = "restyle",
               args = list("mode", "markers"),
               label = "Marker"
          ),
          list(method = "restyle",
               args = list("mode", "lines"),
               label = "Lines"
          )
          
        )
      )
    )
  )