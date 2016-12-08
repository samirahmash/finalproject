# Reads in data as a data table from the International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, and year.
data <- read.csv("./data/ilodata.csv")

# Loads dplyr package to use its functions to manipulate the data.
library(dplyr)

# Filters ILO data for a map by rural/urban area, gender, years, and age in an accessible function.
FilterMapData <- function(df, urbvar, gender, start.year, end.year, age) {
  
  # Filters out column spaces with NA.
  data <- filter(df, !is.na(Obs_Value)) 
  
  # Pares down data for necessary values which are chosen as inputs at the beginning of the function.
  # Then, summarises by occurrences and creates a column representing the mean of the observed values.
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
  mapping.data <- short.data %>% 
    filter(Classif2_Item_Label == urbvar, 
           Sex_Item_Label == gender, 
           age == Classif1_Item_Label,
           Time >= start.year,
           Time <= end.year) %>% 
    group_by(Country_Code) %>%
    summarise(occurrences = n(),
           mean.observations = mean(Obs_Value))
  mapping.data <- mapping.data[!duplicated(mapping.data), ]
  return (mapping.data)
  
}

# Test filtered datatable function.
# mapping.data <- FilterMapData("National", "Total", "Total")
# For some reason, there are duplicates. This deals with that.
