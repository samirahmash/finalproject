library(shiny)
library(plotly)
library(dplyr)
df <- read.csv("./data/ilodata.csv", stringsAsFactors = FALSE)

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
          radioButtons("radio1","Gender", 
                       choices = list("Total",
                                      "Male",
                                      "Female"),
                       selected = "Total"),
          
          radioButtons("radio2", "Area",
                        choices = list("National",
                                       "Urban", 
                                       "Rural"),
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
                      selected = "Total")
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Choropleth Map", plotlyOutput("GlobalMap")),
            tabPanel("Scatter" , plotlyOutput("ComboUnemployment"))
          )
        )
      )
      ),
    tabPanel("International Labor Grouped Bars by Country",
             sidebarLayout(
               sidebarPanel(
                 selectInput("select2", 
                             label = h3("Select a Country"),
                             choices = only.countries, 
                             selected = only.countries[1]),
                 radioButtons("radio3", "Area",
                              choices = list("National",
                                             "Urban", 
                                             "Rural"),
                              selected = "National")
             ),
             mainPanel(
               plotlyOutput("Bar1")
               )
    )
    )
)
)
)