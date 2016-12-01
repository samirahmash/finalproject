source('./scripts/')

shinyUI(fluidPage(
  titlePanel("International Labor Organization - Visualized"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Flowe"), 
                   choices = list("Setosa" = 'setosa', "Versicolor" = 'versicolor',
                                  "Virginica" = 'virginica'),
                   selected = "setosa"),
      
      #  Adds the choice of coor selection to the graph for aesthetic effect
      selectInput("select", label = h3("Select a Country"), 
                  choices = list(), 
                  selected = 'red')
    ),
    mainPanel(
      plotlyOutput("scatter")
    )
  )
)
)