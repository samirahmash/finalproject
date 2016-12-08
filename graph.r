
library(plotly)
library(stringr)


BuildScatter <- function(data, scatter.x, scatter.y) {
  
  #This turns the variable we inputed back into data
  xvariable <- paste0('~', scatter.x)
  yvariable <- paste0('~', scatter.y)
  xaxis <- gsub(".", " ", scatter.x, fixed = TRUE) 
  yaxis <- gsub(".", " ", scatter.y, fixed = TRUE)
  
  #Graphs the plotly scatter point graph with variables as the X and Y axis, allowing you to change what you compare.
  p <- plot_ly(data = data, x = eval(parse(text = xvariable)), y = eval(parse(text = yvariable)), type="scatter", mode = 'markers') %>%
    layout(title = "Labor?",
           
           #Sets the axis labels and range ( range = c(0, 8))
           xaxis = list(title = xaxis),
           yaxis = list(title = yaxis))
  return(p)
}