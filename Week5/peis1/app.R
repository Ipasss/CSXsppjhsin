library(shiny)
library(ggplot2) 

College_ranking100 <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking100.csv")
rank_2012 <- read.csv("~/Documents/GitHub/CSXsp/Week5/rank_2012.csv")
rank_2013 <- read.csv("~/Documents/GitHub/CSXsp/Week5/rank_2013.csv")
rank_2014 <- read.csv("~/Documents/GitHub/CSXsp/Week5/rank_2014.csv")
rank_2015 <- read.csv("~/Documents/GitHub/CSXsp/Week5/rank_2015.csv")


ui <- fluidPage(
  title = "College_Ranking_Top100",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "College_ranking100"',
        checkboxGroupInput("show_vars", "Columns in College_ranking_2012to2015 to show:",
                           names(College_ranking100), selected = names(College_ranking100))
      ),
      conditionalPanel(
        'input.dataset === "rank_2012"',
        checkboxGroupInput("show_vars", "Columns in College_ranking_2012 to show:",
                           names(rank_2012), selected = names(rank_2012))
      ),
      conditionalPanel(
        'input.dataset === "rank_2013"',
        checkboxGroupInput("show_vars", "Columns in College_ranking_2013 to show:",
                           names(rank_2013), selected = names(rank_2013))
      ),
      conditionalPanel(
        'input.dataset === "rank_2014"',
        checkboxGroupInput("show_vars", "Columns in College_ranking_2014 to show:",
                           names(rank_2014), selected = names(rank_2014))
      ),
      conditionalPanel(
        'input.dataset === "rank_2015"',
        checkboxGroupInput("show_vars", "Columns in College_ranking_2015 to show:",
                           names(rank_2015), selected = names(rank_2015))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("College_ranking_2012to2015", DT::dataTableOutput("mytable1")),
        tabPanel("College_ranking_2012", DT::dataTableOutput("mytable2")),
        tabPanel("College_ranking_2013", DT::dataTableOutput("mytable3")),
        tabPanel("College_ranking_2014", DT::dataTableOutput("mytable4")),
        tabPanel("College_ranking_2015", DT::dataTableOutput("mytable5"))
      )
    )
  )
)


server <- function(input, output) {
  
  # choose columns to display
  College_ranking1002 = College_ranking100[sample(nrow(College_ranking100), 400), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(College_ranking1002[, input$show_vars, drop = FALSE])
  })
  
  rank_20122 =rank_2012[sample(nrow(rank_2012), 100), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(rank_20122[, input$show_vars, drop = FALSE])
  })
  rank_20132 =rank_2013[sample(nrow(rank_2013), 100), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(rank_20132[, input$show_vars, drop = FALSE])
  })  
  rank_20142 =rank_2014[sample(nrow(rank_2014), 100), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(rank_20142[, input$show_vars, drop = FALSE])
  })
  rank_20152 =rank_2015[sample(nrow(rank_2015), 100), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(rank_20152[, input$show_vars, drop = FALSE])
  })
}

shinyApp(ui, server)

output$range <- renderPrint({ input$world_rank })
output$range <- renderPrint({ input$national_rank })
output$range <- renderPrint({ input$quality_of_education })
output$range <- renderPrint({ input$alumni_empolyment })
output$range <- renderPrint({ input$quality_of_faculty })
output$range <- renderPrint({ input$publications })
output$range <- renderPrint({ input$influence })
output$range <- renderPrint({ input$citations })
output$range <- renderPrint({ input$broad_impact })
output$range <- renderPrint({ input$patents })
output$range <- renderPrint({ input$score })
