
library(shiny)
library(ggplot2) 
library(dplyr)
if (FALSE) {
  library(RSQLite)
  library(dbplyr)
}

College_ranking100 <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking100.csv")


ui <-fluidPage(
  
  # App title ----
  titlePanel("Sliders"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "College_ranking100"',
        sliderInput("world_rank", label = h4("world_rank"), min = 1, 
                    max = 100, value = c(1, 100))
        
      )
    ),
    mainPanel(
      
      DT::dataTableOutput("values")
    )
  )
)






server <- function(input, output) {
 
    College_ranking100 <- reactive({
    minworld_rank <- input$world_rank[1]
    maxworld_rank <- input$world_rank[2]
    
    College_ranking1002 <- College_ranking100 %>%
      filter(
        world_rank >= minworld_rank,
        world_rank <= maxworld_rank
      )
    College_ranking1003 <- as.data.frame(College_ranking1002())

  })

    output$values <- renderTable(College_ranking100())

  }
  
shinyApp(ui, server)


