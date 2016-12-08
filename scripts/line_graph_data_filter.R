# Loads packages to use their functions.
library(dplyr)

# Data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year.
data <- read.csv("./data/ilodata.csv")

# Filters down our data, excluding rows where there is no observed value.
data <- filter(data, !is.na(Obs_Value)) 

only.countries <- as.list(select(data, Country_Label) %>%
                  unique())

# Filters the data for the for the by country line graph.
FilterScatterCountry <- function(df, urbvar, country) {
  
  # Selects the columns we are interested in looking at.
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
  
    # Gets the rows that are from the selected region.
    country.data <- filter(short.data, Classif2_Item_Label == urbvar) %>%
      
      # Gets the rows containing all the age ranges.
      filter(Classif1_Item_Label == "Total") %>% 
      
      # Gets the rows that have data for all genders.
      subset(Sex_Item_Label %in% 'Total') %>%
      
      # Gets the rows that are about the selected country.
      filter(Country_Label == country)
    
  # Removes all duplicate country data.
  country.data <- country.data[!duplicated(country.data), ]
  return (country.data)
}

