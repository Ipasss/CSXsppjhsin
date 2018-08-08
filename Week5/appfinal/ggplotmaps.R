library(ggmap)
library(ggplot2)

college_map_USA <- read.csv("~/Documents/GitHub/CSXsp/Week5/datas/college_map_USA.csv")

map <- get_map("USA",zoom=4)
ggmap(map,darken = c(0.3, "white")) + 
  geom_point(aes(x = Lon, y = lat, size = score, color = score), data = college_map_USA) +
  geom_text(aes(x = Lon, y = lat,label=institution,size = score, color = score),data=college_map_USA,hjust=0, vjust=0)


