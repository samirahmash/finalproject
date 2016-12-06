library(shiny)
library(plotly)

source('./Scripts/buildScatter.R')
source('./scripts/datafunctions.R')

df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# Gets the countries names
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
          plotlyOutput("GlobalMap"),
          plotlyOutput("ComboUnemployment")
        )
      )
    ),
    tabPanel("International Labor Grouped Bars by Country",
             sidebarLayout(
               sidebarPanel(
                 
                 # Allows you to select a country
                 selectInput("select2", 
                             label = h3("Select a Country"),
                             choices = only.countries, 
                             selected = only.countries[1]),
                 
                 radioButtons("radio3", "Area",
                              choices = list("Rural",
                                             "Urban", 
                                             "National"),
                              selected = "National")
               ),
               mainPanel(
                 plotlyOutput("Bar1")
               )
             )
      ),
  


      # Adds the tab for the unemployment by country
      tabPanel("Internation Labor Scatterplot",
          sidebarLayout(
            sidebarPanel(  
               # Allows you to select a country
               selectInput("selectCountry", 
                           label = h3("Select a Country"),
                           choices = only.countries, 
                           selected = only.countries[1]),
                 
               # Allows you to select a region
               radioButtons("radioCountry", "Area",
                            choices = list("Rural",
                                           "Urban", 
                                           "National"),
                            selected = "National")
             )
          ),
          # Plots the graph for the unemployment rates
          mainPanel(
             plotlyOutput("BuildScatter")
          )
        )
      )
    )
)
         
    



