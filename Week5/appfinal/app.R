library(shiny)
library(ggplot2) 

College_ranking100 <- read.csv("./College_ranking100.csv")
College_ranking <- read.csv("./College_ranking.csv")


ui <- 
  navbarPage("About College Ranking", 
             tags$style(HTML("
        .tabs-above > .nav > li[class=active] > a {
           background-color: #000;
           color: #FFF;
        }")),
     tabPanel("Explore the Data",
  
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
               
               tableOutput("values")
              
             )
           )
  )
     ),   
  tabPanel("Maps",
           
           fluidRow( 
             column(4, wellPanel(
               radioButtons("picture", "Maps:",
                            c("USA", "UK","Taiwan","Switzerland","Sweden","South Korea","Singapore","Russia","Norway","Netherlands","Japan","Israel","Germany","France","Denmark","China","Canada","Belgium","Australia"))
             )),
             column(4,
                               imageOutput("image"))))
  )

        

library(png)

server <- function(input, output) {

  # choose columns to display
  College_ranking1002 = College_ranking100[sample(nrow(College_ranking100),400), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(College_ranking1002[, input$show_vars, drop = FALSE])
  })
  
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

  output$image <- renderImage({
    if (is.null(input$picture))
      return(NULL)
    
    if (input$picture == "USA") {
      return(list(
        src = "./USAmap.png",
        contentType = "image/png",
        alt = "USA"
      ))
    } else if (input$picture == "UK") {
      return(list(
        src = "UKmap.png",
        filetype = "image/png",
        alt = "UK"
      ))
    } else if (input$picture == "Taiwan") {
      return(list(
        src = "Taiwanmap.png",
        filetype = "image/png",
        alt = "Taiwan"
      ))
    } else if (input$picture == "Switzerland") {
      return(list(
        src = "Switzerlandmap.png",
        filetype = "image/png",
        alt = "Switzerland"
      ))
    } else if (input$picture == "Sweden") {
      return(list(
        src = "Swedenmap.png",
        filetype = "image/png",
        alt = "Sweden"
      ))
    } else if (input$picture == "South Korea") {
      return(list(
        src = "SouthKoreamap.png",
        filetype = "image/png",
        alt = "South Korea"
      ))
    } else if (input$picture == "Singapore") {
      return(list(
        src = "Singaporemap.png",
        filetype = "image/png",
        alt = "Singapore"
      ))
    } else if (input$picture == "Russia") {
      return(list(
        src = "Russiamap.png",
        filetype = "image/png",
        alt = "Russia"
      ))
    } else if (input$picture == "Norway") {
      return(list(
        src = "Norwaymap.png",
        filetype = "image/png",
        alt = "Norway"
      ))
    } else if (input$picture == "Netherlands") {
      return(list(
        src = "Netherlandsmap.png",
        filetype = "image/png",
        alt = "Netherlands"
      ))
    } else if (input$picture == "Japan") {
      return(list(
        src = "Japanmap.png",
        filetype = "image/png",
        alt = "Japan"
      ))
    } else if (input$picture == "Israel") {
      return(list(
        src = "Israelmap.png",
        filetype = "image/png",
        alt = "Israel"
      ))
    } else if (input$picture == "Germany") {
      return(list(
        src = "Germanymap.png",
        filetype = "image/png",
        alt = "Germany"
      ))
    } else if (input$picture == "France") {
      return(list(
        src = "Francemap.png",
        filetype = "image/png",
        alt = "France"
      ))
    } else if (input$picture == "Denmark") {
      return(list(
        src = "Denmarkmap.png",
        filetype = "image/png",
        alt = "Denmark"
      ))
    } else if (input$picture == "China") {
      return(list(
        src = "Chinamap.png",
        filetype = "image/png",
        alt = "China"
      ))
    } else if (input$picture == "Canada") {
      return(list(
        src = "Canadamap.png",
        filetype = "image/png",
        alt = "Canada"
      ))
    } else if (input$picture == "Belgium") {
      return(list(
        src = "Belgiummap.png",
        filetype = "image/png",
        alt = "Belgium"
      ))
    } else if (input$picture == "Australia") {
      return(list(
        src = "Australiamap.png",
        filetype = "image/png",
        alt = "Australia"
      ))
    }
    
  }, deleteFile = FALSE)
    


}
 
  



shinyApp(ui, server)


