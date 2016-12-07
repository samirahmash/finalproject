# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...

# load packages
library(dplyr)
data <- read.csv("./data/ilodata.csv")
# unique(data$Survey_Label)
# unique(data$Source_Label)
# filter down our data, excluding rows where there is no observed value
data <- filter(data, !is.na(Obs_Value)) 

# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Country_Code, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
only.ages <- select(data, Classif1_Item_Label) %>% unique()
only.countries <- as.list(select(data, Country_Label) %>%
                  unique())

# filter down results to both sexes, urban and rural, all ages, and latest year data was collected

FilterMapData <- function(df, urbvar, gender, start.year, end.year, age) {
  data <- filter(df, !is.na(Obs_Value)) 
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

#mapping.data <- FilterMapData("National", "Total", "Total")
# for some reason there are duplicates, this deals with that

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


