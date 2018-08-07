
library(shiny)
library(ggplot2) 


College_ranking100 <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking100.csv")


ui <-fluidPage(
  
  # App title ----
  titlePanel("Sliders"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
                                   conditionalPanel(
                                     'input.dataset === "College_ranking"',
                                     sliderInput("world_rank", label = h4("world_rank"), min = 1, 
                                                 max = 100, value = c(1, 100)),
                                     sliderInput("national_rank", label = h4("national_rank"), min = 1, 
                                                 max = 58, value = c(1, 58)),
                                     sliderInput("quality_of_education", label = h4("quality_of_education"), min = 1, 
                                                 max = 367, value = c(1, 367))
                                     ,
                                     sliderInput("alumni_empolyment", label = h4("alumni_empolyment"), min = 1, 
                                                 max = 567, value = c(1, 567)),
                                     sliderInput("quality_of_faculty", label = h4("quality_of_faculty"), min = 1, 
                                                 max = 218, value = c(1, 218)),
                                     sliderInput("publications", label = h4("publications"), min = 1, 
                                                 max = 406, value = c(1, 406)),
                                     sliderInput("influence", label = h4("influence"), min = 1, 
                                                 max = 389, value = c(1, 389)),
                                     sliderInput("citations", label = h4("citations"), min = 1, 
                                                 max = 645, value = c(1, 645)),
                                     sliderInput("broad_impact", label = h4("broad_impact"), min = 1, 
                                                 max = 388, value = c(1, 388)),
                                     sliderInput("patents", label = h4("patents"), min = 1, 
                                                 max = 871, value = c(1, 871)),
                                     sliderInput("score", label = h4("score"), min = 40, 
                                                 max = 100, value = c(40, 100))
                                     
                                   )
                                 ),
                                 mainPanel(
                                   
                                   DT::dataTableOutput("values")
                                 )
                               )
                      )
             





server <- function(input, output) {


  output$values <- renderTable({

  })
  
  
}


shinyApp(ui, server)


