library(shiny)

source('./datafunctions.R')
source('./Scripts/buildScatter.R')

library(plotly)
source('./scripts/datafunctions.R')
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)


only.countries <- select(df, Country_Label) %>% unique()
only.ages <- select(df, Classif1_Item_Label) %>% unique()
shinyUI(fluidPage(
  tabsetPanel(
    tabPanel("International Labor Organization - Visualized",
      sidebarLayout(
        sidebarPanel(
          radioButtons("radio1","Gender", 
                       choices = list("Female",
                                      "Male",
                                      "Total"),
                       selected = "Total"),
          
          radioButtons("radio2", "Area",
                        choices = list("Rural",
                                       "Urban", 
                                       "National"),
                        selected = "National"),
        
          sliderInput("slider2", "Slider Range", 
                      min = min(df$Time), 
                      max = max(df$Time), 
                      value = c(1995, 1996),
                      round = TRUE,
                      step = 1,
                      animate = TRUE
                      ),
          
          selectInput("select", 
                      label = h3("Select an Age Range"),
                      choices = only.ages, 
                      selected = only.ages[1])
        ),
        mainPanel(
          plotlyOutput("GlobalMap")
        )
      )
      ),
    tabPanel("Internation Labor Scatterplot",
             sidebarLayout(
               sidebarPanel(
                 selectInput("select2", 
                             label = h3("Select a Country"),
                             choices = only.countries, 
                             selected = only.countries[1])
               ),
               mainPanel(
                 plotlyOutput("PieChart")
               )
             )
             )

    )
)

