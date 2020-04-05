library(janitor)
library(tidyverse)
library(readxl)



#Importing data from EXCEL file available at https://fingertips.phe.org.uk/documents/Historic%20COVID-19%20Dashboard%20Data.xlsx

uk_cases <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  2)

uk_deaths <- read_xlsx("data/Historic COVID-19 Dashboard Data(1).xlsx", skip = 7, sheet =  3)

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

#imports data, clean variable names and pivot data to longer when needed

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


#Prepare tibble for analysis, fix variable names and join tables by date
uk_total_analysis <- left_join(uk_cases, uk_deaths, by ="date") %>% 
                        left_join(uk_recovered, by ="date") %>% 
                        rename(daily_cases = cases,
                               confirmed_cases = cumulative_cases,
                               daily_deaths = deaths,
                               cumulative_deaths_uk = uk,
                               cumulative_deaths_england = england,
                               cumulative_deaths_scotland = scotland,
                               cumulative_deaths_wales = wales,
                               cumulative_deaths_northern_ireland = northern_ireland,
                               recovered_count = cumulative_counts
                        )
                  
#Ploting data to prepare dashboard

#Whole UK analysis

uk_total_analysis %>% 
          ggplot() + 
          theme(legend.position="left") +
          aes(x = date) +
          geom_point(colour = "steelblue") + 
          aes(
            y = confirmed_cases,
          ) +
          # geom_line(colour = "light red") + 
          # aes(
          #   y = uk
          # ) +
          labs(
            title = "Covid-19 confirmed cases in the UK",
            x = NULL,
            y = "Total cases",
            caption = "Total Covid-19 cases detected in the UK"
          )  + 
          scale_y_continuous(sec.axis = sec_axis(
                              name = "Cases per day", 
                              ~ . / 3,
                             # labels = c(0,1000,2000,3000,4000,5000,6000,7000,8000,9000)
                              ), 
                             n.breaks = 8,
                             #limits = c(0, 6000)
                             ) +
          geom_bar(fill = "purple", 
                  stat = "identity", 
                  aes(
                      y = daily_cases * 3
                      )) +
          geom_bar(fill = "light blue", 
                   stat = "identity", 
                   aes(
                     y = daily_deaths * 3
                   )) 
          
#Daath patients in the UK and by country
uk_total_analysis %>% 
      ggplot() +
      aes(x = date) +
      theme(legend.position="left") +
      geom_bar(fill = "red", stat = "identity") +
      aes(
        y = cumulative_deaths_uk
        
      ) + 
      geom_bar(fill = "blue", stat = "identity") +
      aes(
        y = daily_deaths
        
      ) + 
      labs(
        x = "Date",
        y = "Total cases",
        caption = "Total Covid-19 deaths in the UK")


#Recovered patients in the UK
uk_total_analysis %>% 
  ggplot() +
  theme(legend.position="left") +
  geom_bar(fill = "Dark Green", stat = "identity") +
  aes(
    x = date,
    y = recovered_count,
    
  ) + 
  labs(
    x = "Date",
    y = "Total cases",
    caption = "Total Covid-19 recovered cases in the UK")

