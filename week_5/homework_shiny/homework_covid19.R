library(janitor)
library(tidyverse)
library(readxl)
library(shiny)


#Importing data from EXCEL file available at https://fingertips.phe.org.uk/documents/Historic%20COVID-19%20Dashboard%20Data.xlsx

uk_cases <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  2)

uk_deaths <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 6, sheet =  3)

uk_countries <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  4)

uk_nhs_regions <-  total_uk_deaths <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  5)

uk_utlas <-  total_uk_deaths <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  6)

uk_recovered <-  total_uk_deaths <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 5, sheet =  7)

# UK COVID-19 Cases, Deaths and Recovered Patients

# This spreadsheet contains all the data published on the PHE Dashboard each day since it launched on Monday 9 March 2020.
# 
# The live dashboard is available at: https://www.arcgis.com/apps/opsdashboard/index.html#/f94c3c90da5b4e9f9a0b19484dd4bb14
#   
#   All data are as published on the day and have not been updated or revised.

#CLEANING STEPS

uk_cases <- uk_cases %>% 
              clean_names()

uk_deaths <- uk_deaths %>% 
              clean_names()

uk_countries <- uk_countries %>% 
                  pivot_longer(
                    cols= starts_with("43"),
                    names_to = "date_code",
                    values_to = "total"
                  ) %>% 
                clean_names()

uk_recovered <- uk_recovered %>% 
                clean_names()

uk_nhs_regions <- uk_nhs_regions %>% 
                    pivot_longer(
                      cols= starts_with("43"),
                      names_to = "date_code",
                      values_to = "total"
                    ) %>% 
                    clean_names()

uk_utlas <- uk_utlas %>% 
              pivot_longer(
                cols= starts_with("43"),
                names_to = "date_code",
                values_to = "total"
              ) %>% 
              clean_names()

                  
#Ploting data to prepare dashboard

uk_cases %>% 
          ggplot() +
          geom_point(colour = "steelblue") +
          aes(
            x = date,
            y = cumulative_cases,
          ) + 
          labs(
            x = "Date",
            y = "Total cases",
            caption = "Total Covid-19 cases detected in the UK"
          )  + 
          scale_y_continuous(sec.axis = sec_axis(
                              name = "Cases per day", 
                              ~ . / 5, 
                              geom_bar(fill = "purple", 
                                       stat = "identity", 
                                       aes(
                                         x = date,
                                         y = cases
                                       )))) 
          

uk_deaths %>% 
      ggplot() +
      geom_bar(fill = "red", stat = "identity") +
      aes(
        x = date,
        y = uk
        
      ) + 
      labs(
        x = "Date",
        y = "Total cases",
        caption = "Total Covid-19 deaths in the UK")

uk_recovered %>% 
  ggplot() +
  geom_bar(fill = "Dark Green", stat = "identity") +
  aes(
    x = date,
    y = cumulative_counts,
    
  ) + 
  labs(
    x = "Date",
    y = "Total cases",
    caption = "Total Covid-19 recovered cases in the UK")

