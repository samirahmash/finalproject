# data from International Labor Organization on unemployment from 1990 to 2015, 
# broken down by country, gender, age group, urban/rural, year
# NOTE: Can't figure out how to make a general and shortened file path for some reason...
data <- read.csv("~/Documents/GitHub/finalproject/data/ilodata.csv")


# load packages
library(dplyr)

# pare down columns in dataframe to just country, sex, age, urban status, year, and unemployment
short.data <- select(data, Country_Label, Sex_Item_Label, 
                     Classif1_Item_Label, Classif2_Item_Label, Time, Obs_Value)


# filter down results to both sexes, urban and rural, all ages, and latest year data was collected
mapping.data <- filter(short.data, Classif2_Item_Label == 'National') %>% 
  filter(Sex_Item_Label == "Total") %>%
  filter(Classif1_Item_Label == "Total") %>% 
  group_by(Country_Label) %>% 
  filter(Time == max(Time))

# for some reason there are duplicates, this deals with that
mapping.data <- mapping.data[!duplicated(mapping.data), ]

View(mapping.data)
