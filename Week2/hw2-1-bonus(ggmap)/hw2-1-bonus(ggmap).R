##將資料畫在地圖上
library(ggmap)
library(mapproj)
###下載紫外線即時監測資料的 csv 檔，將資料讀進 R 中。
uv <- read.csv("UV_20180717190444 2.csv")
###原始的經緯度資料是以度分秒表示，在使用前要轉換為度數表示。
lon.deg <- sapply((strsplit(as.character(uv$WGS84Lon), ",")), as.numeric)
uv$lon <- lon.deg[1, ] + lon.deg[2, ]/60 + lon.deg[3, ]/3600
lat.deg <- sapply((strsplit(as.character(uv$WGS84Lat), ",")), as.numeric)
uv$lat <- lat.deg[1, ] + lat.deg[2, ]/60 + lat.deg[3, ]/3600
###把資料加入地圖中
library(ggmap)
map <- get_map(location = c(lon = 121, lat = 23.5), zoom = 8, language = "zh-TW", maptype = "hybrid")
ggmap(map) + geom_point(aes(x = lon, y = lat, size = UVI, color = "red"), data = uv) + ggtitle("UVI of Taiwan")