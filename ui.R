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
             ),
               # Plots the graph for the unemployment rates
               mainPanel(
                 plotlyOutput("BuildScatter")
               ))
             )
         )
    )
)

