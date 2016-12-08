# Loads packages to use their functions when publishing scripts.
library(shiny)
library(plotly)
library(dplyr)

# Identifies sources in scripts file.
source('./Scripts/buildScatter.R')
source('./scripts/line_graph_data_filter.R')

# Reads rural and urban unemployment data from International Labor Organization into dataframe.
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

# Pares down data by country name, urban or rural status, and gender.
only.countries <- select(df, Country_Label) %>%
  unique() %>%
  arrange(Country_Label)
only.ages <- select(df, Classif1_Item_Label) %>%
  unique() %>%
  arrange(Classif1_Item_Label)

shinyUI(fluidPage(
  titlePanel("International Labor Statistics - Unemployment"),
  tabsetPanel(
    tabPanel("International Labor Organization - Visualized",
             
      sidebarLayout(
        
        sidebarPanel(
          
          # Uses radio buttons to choose gender, between male, female, and total unemployment percentages for a given country.
          radioButtons("radio1","Gender", 
                       choices = list("Total",
                                      "Male",
                                      "Female"),
                       selected = "Total"),
          
          # Uses radio buttons to choose urban, rural, or national unemployment percentages for a given country.      
          radioButtons("radio2", "Area",
                        choices = list("National",
                                       "Urban", 
                                       "Rural"),
                        selected = "National"),
          
          # User can choose a range of years to view unemployment percentages for, internationally.
          # Pressing play, the user can view the range of years, moving forward through time.
          sliderInput("slider2", "Slider Range", 
                      min = min(df$Time), 
                      max = max(df$Time), 
                      value = c(1995, 1996),
                      round = TRUE,
                      step = 1,
                      animate = TRUE
                      ),
          
          # User can select from a drop down menu of age ranges.
          selectInput("select", 
                      label = h3("Select an Age Range"),
                      choices = only.ages, 
                      selected = "Total")
        ),
        
        # Publishes functions from scripts files to display a Choropleth map of international unemployment
        # percentages and scatter plot of urban vs. rural unemployment.
        # They are separated by tabs.
        mainPanel(
          tabsetPanel(
            tabPanel("Choropleth Map", plotlyOutput("GlobalMap")),
            tabPanel("Scatter" , plotlyOutput("ComboUnemployment"))
          )
        )
      )
    ),
    
    # Creates a bar chart for each country to show male, female, and total unemployment percentages for a 
    # specified country, by urban, rural, or national status.
    tabPanel("International Labor Grouped Bars by Country",
             sidebarLayout(
               sidebarPanel(
                 
                 # Users choose a country from a drop-down menu.
                 selectInput("select2", 
                             label = h3("Select a Country"),
                             choices = only.countries, 
                             selected = only.countries[1]),
                 
                 # Users choose what area data they want to view gender unemployment information from radio buttons.
                 radioButtons("radio3", "Area",
                              choices = list("National",
                                             "Urban", 
                                             "Rural"),
                              selected = "National")
             ),
             
             # Outputs bar chart.
             mainPanel(
               plotlyOutput("Bar1")
               )
             )
      ),
  
      # Adds the tab for the unemployment by country.
      tabPanel("International Labor Scatterplot",
          sidebarLayout(
            sidebarPanel(  
               # Allows users to select a country.
               selectInput("selectCountry", 
                           label = h3("Select a Country"),
                           choices = only.countries, 
                           selected = only.countries[1]),
                 
               # Allows users to select a region.
               radioButtons("radioCountry", "Area",
                            choices = list("Rural",
                                           "Urban", 
                                           "National"),
                            selected = "National")
             
          ),
          # Plots the graph for the unemployment rates.
          mainPanel(
             plotlyOutput("BuildScatter")
          )
          )
        )
      )
    )
 )
