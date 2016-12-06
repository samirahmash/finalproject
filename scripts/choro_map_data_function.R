# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...

# load packages
library(dplyr)
data <- read.csv("./data/ilodata.csv")

# filter down our data, excluding rows where there is no observed value
data <- filter(data, !is.na(Obs_Value)) 

<<<<<<< HEAD:scripts/datafunctions.R
only.countries <- as.list(select(data, Country_Label) %>%
                  unique())
=======
# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Country_Code, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
only.ages <- select(data, Classif1_Item_Label) %>% unique()
only.countries <- as.list(select(data, Country_Label) %>%
                  unique())

# filter down results to both sexes, urban and rural, all ages, and latest year data was collected
>>>>>>> 9ab8315ed151f52bf2e247bcc2e2b6bdbad1a67d:scripts/choro_map_data_function.R

# Filters the data for the for the by country line graph
FilterScatterCountry <- function(df, urbvar, country) {
  # Selects the columns we are interested in looking at
  short.data <- select(df, Country_Label, Country_Code, Sex_Item_Label, 
                       Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
    # Gets the rows that are from the selected region
    country.data <- filter(short.data, Classif2_Item_Label == urbvar) %>%
      
      # Gets the rows containing all the age ranges
      filter(Classif1_Item_Label == "Total") %>% 
      # Gets the rows that have data for all genders
      subset(Sex_Item_Label %in% 'Total') %>%
      # Gets the rows that are about the selected country
      filter(Country_Label == country)
  # Removes all duplicant country data
  country.data <- country.data[!duplicated(country.data), ]
  return (country.data)
}
<<<<<<< HEAD:scripts/datafunctions.R
=======

#mapping.data <- FilterMapData("National", "Total", "Total")
# for some reason there are duplicates, this deals with that
>>>>>>> 9ab8315ed151f52bf2e247bcc2e2b6bdbad1a67d:scripts/choro_map_data_function.R

FilterScatterCountry <- function(){
  scatter.data <- select(short.data, Classif_Item_)
}
FilterScatterCountry <- function(urbvar, country) {
  
  country.data <- filter(short.data, Classif2_Item_Label == urbvar) %>%
    filter(Classif1_Item_Label == "Total") %>% 
    subset(Sex_Item_Label %in% 'Total') %>%
    filter(Country_Label == country) 
  country.data <- country.data[!duplicated(country.data), ]
  return (country.data)
}


