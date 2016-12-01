# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
data <- read.csv("~/Documents/GitHub/finalproject/data/ilodata.csv")


# load packages
library(dplyr)

# filter down our data, excluding rows where there is no observed value
data <- filter(data, !is.na(Obs_Value)) 

# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Country_Code, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)
only.countries <- select(data, Country_Label) %>%
  unique()

# filter down results to both sexes, urban and rural, all ages, and latest year data was collected
FilterMapData <- function(urbvar, gender, age) {
  mapping.data <- filter(short.data, Classif2_Item_Label == urbvar) %>% 
    filter(Sex_Item_Label == gender) %>%
    filter(Classif1_Item_Label == age) %>% 
    group_by(Country_Label) %>% 
    filter(Time == max(Time))
  mapping.data <- mapping.data[!duplicated(mapping.data), ]
  return (mapping.data)
}
#mapping.data <- FilterMapData("National", "Total", "Total")
# for some reason there are duplicates, this deals with that

