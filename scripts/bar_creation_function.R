# Loads packages to use plotly and dplyr functions.
library(plotly)
library(dplyr)

# Creates function to make a plotly bar chart with male, female, and total unemployment percentages in
# particular countries.
UnemploymentBar <- function(df) {
  gender.hist <- plot_ly(df, 
                         x = ~Time,
                         y = ~male.mean,
                         type = "bar",
                         name = "Male Unemployment Percentage"
                         ) %>%
    add_trace(
      y = ~female.mean,
      name = "Female Unemployment Percentage"
      ) %>%
    add_trace(
      y = ~total.mean,
      name = "Total Unemployment Percentage"
      ) %>%
    layout(yaxis = list(title = "Percentage Unemployment"),
           xaxis = list(title = "Year"),
           barmode = "group")
  return(gender.hist)
}