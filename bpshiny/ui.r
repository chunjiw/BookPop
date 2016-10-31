shinyUI(fluidPage(
  
  titlePanel("BookPop"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Choose a plot"),
                   choices = list("pop by month" = 1, "publishers" = 2), 
                   selected = 1)
    ),
    
    mainPanel =  mainPanel(plotOutput("p"),
                           verbatimTextOutput("explaintext"))
  )
  
))