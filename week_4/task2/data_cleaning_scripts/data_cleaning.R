#LOads libraries
library(tidyverse)
library(here)
library(janitor)
library(tidyr)
library(stringr)

# The main data is in the file cake-ingredients-1961.csv, there is supplementary data
#that converts from short form ingredients to long form in cake_ingredient_code.csv.
#
# 1.2.1 Some cleaning hints
# 
# This data isn’t in tidy format. You’ll need to figure out how to get it into our 
# classic data format. We want the actual ingredient names, not the abbreviations. 
# You’ll find these in cake_ingredient_code.csv



#Read files and import them as data.frame

cake_ingredients_code <- read_csv(here("raw_data/cake_ingredient_code.csv"))

cake_ingredients <- read_csv(here("raw_data/cake-ingredients-1961.csv"))

#checks data dimensions

dim(cake_ingredients) #18 35

dim(cake_ingredients_code) #34 3

names(cake_ingredients)
# [1] "Cake" "AE"   "BM"   "BP"   "BR"   "BS"   "CA"   "CC"   "CE"   "CI"   "CS"   "CT"  
# [13] "DC"   "EG"   "EY"   "EW"   "FR"   "GN"   "HC"   "LJ"   "LR"   "MK"   "NG"   "NS"  
# [25] "RM"   "SA"   "SC"   "SG"   "SR"   "SS"   "ST"   "VE"   "WR"   "YT"   "ZH"  


names(cake_ingredients_code)

# "code" "ingredient" "measure"  

#Clean column names

cake_ingredients_clean <- cake_ingredients %>% 
  pivot_longer(cols = c("AE", "BM", "BP", "BR", "BS", "CA", "CC", "CE", "CI", "CS", "CT",  
"DC", "EG", "EY", "EW", "FR", "GN", "HC", "LJ", "LR", "MK", "NG", "NS",
"RM", "SA", "SC", "SG", "SR", "SS", "ST", "VE", "WR", "YT", "ZH"), 
               names_to = "code", 
               values_to = "quantity") %>% #pivots table to longer, using code as name and quantity as value
  filter(is.na(quantity) == FALSE)  #drop ingredients not used

#join both files adding actual ingredient names and quantity
cake_ingredients_clean <-  left_join(cake_ingredients_clean, cake_ingredients_code, by = "code") %>% 
  clean_names() %>% 
  mutate(ingredient = tolower(ingredient))

#Writes/creates cleaned CSV file
write_csv(cake_ingredients_clean, "clean_data/cake_ingredients_clean.csv")
  
  
  
  