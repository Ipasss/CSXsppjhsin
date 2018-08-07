library(shiny)
library(ggplot2) 

College_ranking100 <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking100.csv")
College_ranking <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking.csv")


ui <- 
  navbarPage("About College Ranking", 
     tabPanel("Explore the Data 1",
  
  fluidRow(
    column(4,
           selectInput("country",
                       "Country:",
                       c("All",
                         unique(as.character(College_ranking100$country))))
    ),
    column(4,
           selectInput("institution",
                       "Institution:",
                       c("All",
                         unique(as.character(College_ranking100$institution))))
    ),
    column(4,
           selectInput("year",
                       "Year:",
                       c("All",
                         unique(as.character(College_ranking100$year))))
    )
  ),
  fluidRow(DT::dataTableOutput("table")),
  tabPanel("Explore the Data 2",
  
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "College_ranking"',
        checkboxGroupInput("show_vars", "Columns in College_ranking to show:",
                           names(College_ranking), selected = names(College_ranking))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("College_ranking", DT::dataTableOutput("mytable1"))
      )
    )
  )
  ),
  tabPanel("Explore the Data 3",
           
           sidebarLayout(
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
               
               tableOutput("values"),
               uiOutput("focal")
              
             )
           )
  )
     )
  )

        



server <- function(input, output) {

  # choose columns to display
  College_ranking1002 = College_ranking100[sample(nrow(College_ranking100),400), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(College_ranking1002[, input$show_vars, drop = FALSE])
  })
  output$range <- renderPlot({ hist(rnorm(input$world_range)) })
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- College_ranking100
    if (input$country != "All") {
      data <- data[data$country == input$country,]
    }
    if (input$institution != "All") {
      data <- data[data$institution == input$institution,]
    }
    if (input$year != "All") {
      data <- data[data$year == input$year,]
    }
    data
  }))
  sliderValues <- reactive({
    
    data.frame(
      Name = c("world_rank",
               "institution",
               "country",
               "national_rank",
               "quality_of_education",
               "alumni_employment",
               "quality_of_faculty",
               "publications",
               "influence",
               "citations",
               "broad_impact",
               "patents",
               "score",
               "year"),
      Value = as.character(c(input$world_rank,
                             input$institution,
                             input$country,
                             input$national_rank,
                             input$quality_of_education,
                             input$alumni_empolyment,
                             input$quality_of_faculty,
                             input$publications,
                             input$influence,
                             input$citations,
                             input$broad_impact,
                             input$patents,
                             input$score
      )),
      stringsAsFactors = FALSE)
    
  })
  output$values <- renderTable({
    sliderValues()
  })

 
  
}


shinyApp(ui, server)


