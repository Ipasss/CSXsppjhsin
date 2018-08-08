library(shiny)
library(ggmap)
library(ggplot2)

# load data
college_map_USA <- read.csv("~/Documents/GitHub/CSXsp/Week5/college_map_USA.csv")
map <- get_map(location = 'USA', zoom = 4)


ui <- fluidPage (
  plotOutput(outputId="mapOut"
  )
)
server <- function(input,output) {
  
  output$mapOut <- renderPlot({
    map <- get_map(location = 'USA', zoom = 4)
    mapPoints <-  ggmap(map,darken = c(0.3, "white")) + geom_point(aes(x = Lon, y = lat, size = score, color = score), data = college_map_USA) +geom_text(aes(x = Lon, y = lat,label=institution,size = score, color = score),data=college_map_USA,hjust=0, vjust=0,check_overlap = TRUE)

  })
  
}

shinyApp(server = server, ui = ui)