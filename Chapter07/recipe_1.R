library(ggplot2)
library(ggridges)
ggplot(airquality) + aes(Temp, Month, group = Month) + geom_density_ridges()
ggplot(airquality) + aes(Temp, as.factor(Month) ) + geom_density_ridges()


library(viridis)
ggplot(airquality) + aes(Temp, Month, group = Month,  fill = ..x..) + 
  geom_density_ridges_gradient() + 
  scale_fill_viridis(option = "C", name = "Temp")


library(tidyr)
airquality %>%
  gather(key = "Measurement", value = "value", Ozone, Solar.R, Wind, Temp ) %>%
  ggplot() + aes(value, Month, group = Month) + 
  geom_density_ridges_gradient() +
  facet_wrap( ~ Measurement, scales = "free")