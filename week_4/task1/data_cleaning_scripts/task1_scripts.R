# The data_cleaning_scripts folder will contain your code (clear & commented) 
# used to clean the data. At the end of the script, you should write your cleaned 
# dataset to a csv file in the clean_data folder. This should be a .R script.

library(tidyverse)
library(here)
library(janitor)
library(tidyr)

#Reads file and imports it as a data.frame

decathlon_data <- read_rds(here("raw_data/decathlon.rds"))

#checks data dimensions

dim(decathlon_data)

names(decathlon_data)

#Clean column names

decathlon_data_clean <- clean_names(decathlon_data) %>% 

rownames_to_column("surname") %>% #Row names transformed into column
  
mutate(surname = tolower(surname)) %>% #Changes names into lowercase

pivot_longer(cols = c("x100m", "long_jump", "shot_put", "high_jump", "x400m", "x110m_hurdle", "discus", "pole_vault", "javeline", "x1500m"), 
             names_to = "event", 
             values_to = "scores") %>% #pivots table to longer, using each event as name and score as value
  
mutate(event = if_else(event == "x100m", "running_100m", event),
       event = if_else(event == "x400m", "running_400m", event),
       event = if_else(event == "x1500m", "running_1500m", event),
       event = if_else(event == "x110m_hurdle", "hurdle_110m", event)
       ) #Changes events to human readable format by changing content once found

#Writes/creates cleaned CSV file

write_csv(decathlon_data_clean, "clean_data/decathlon_data_clean.csv")