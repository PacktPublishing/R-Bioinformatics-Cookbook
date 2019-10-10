library(heatmap3)

heatmap(WorldPhones)
heatmap(WorldPhones, Rowv = NA, Colv = NA)

rc <- rainbow(nrow(WorldPhones), start = 0, end = .3)
cc <- rainbow(ncol(WorldPhones), start = 0, end = .3)

heatmap(WorldPhones, ColSideColors = cc)

library(RColorBrewer)
heatmap(WorldPhones, ColSideColors = cc, 
        col = colorRampPalette(brewer.pal(8, "PiYG"))(25))

## There's more
heatmap(WorldPhones, ColSideColors = cc, scale = "column")


##See also
library(gplots)
heatmap.2(WorldPhones, ColSideColors = cc, 
          col = colorRampPalette(brewer.pal(8, "PiYG"))(25))
