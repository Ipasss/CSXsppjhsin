
  library(shiny)
library(DT)
library(dplyr)
set.seed(422015)
DF1 <- data.frame(V1=sample(x = c("A1", "A2", "B2", "B4", "C9"), size = 100, replace = T),
                  V2=runif(n = 100,min = -100, max = 100))

shinyServer(function(input, output) {
  observe({
    
    output$tbl = renderDataTable({
      DF1 %>%
        filter(V2>input$slider2[1], V2<input$slider2[2], 
               V1 %in% input$checkGroup) %>%
        group_by(V1) %>%
        summarise(mean=mean(V2)) %>%
        datatable(extensions = 'TableTools', 
                  rownames = FALSE, 
                  options = list(pageLength = 5, lengthMenu = c(5, 10, 15, 50, 100),
                                 dom = 'T<"clear">lfrtip',
                                 tableTools = list(sSwfPath = copySWF())
                  ))
    })
    
    
  })
  
})


ui:
  
  library(shiny)

shinyUI(fluidPage(
  fluidRow(
    
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("slider2", label = h3("Slider Range"), min = 0, 
                       max = 100, value = c(-100, 100)),
           checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                              choices = list("A1" = "A1", "A2" = "A2", "B2" = "B2", "B4"="B4", "C9"="C9"),
                              selected = c("A1", "A2", "B2", "B4", "C9"))
    )
  ),
  
  hr(),
  
  fluidRow(
    DT::dataTableOutput('tbl')
  )
  
))