# The data for this project is in the file seabirds.xls, in particular the sheets 
# Bird data by record ID and Ship data by record ID.
#
# 1.3.1 Some cleaning hints
# 
# Do we need all the variables for this data?
#   You’ll need to join the ship data to the bird record data
# 


library(tidyverse)
library(here)
library(janitor)
library(tidyr)
library(readxl)


#Reads file and imports it as a data.frame

seabirds_ship_data <- read_xls(here("../raw_data/seabirds.xls"), sheet = 1)

seabirds_bird_data <- read_xls(here("../raw_data/seabirds.xls"), sheet = 2)

#checks data dimensions

dim(seabirds_ship_data) #12310    27

dim(seabirds_bird_data) #49019    26

names(seabirds_ship_data)
# 1] "RECORD"    "RECORD ID" "DATE"      "TIME"      "LAT"       "LONG"      "EW"       
# [8] "SACT"      "SPEED"     "SDIR"      "CLD"       "PREC"      "WSPEED"    "WDIR"     
# [15] "ATMP"      "APRS"      "SSTE"      "STMP"      "SAL"       "DEPTH"     "OBS"      
# [22] "CSMETH"    "MONTH"     "SEASN"     "LONG360"   "LATCELL"   "LONGECELL"

names(seabirds_bird_data)
# 
# [1] "RECORD"                                                      
# [2] "RECORD ID"                                                   
# [3] "Species common name (taxon [AGE / SEX / PLUMAGE PHASE])"     
# [4] "Species  scientific name (taxon [AGE /SEX /  PLUMAGE PHASE])"
# [5] "Species abbreviation"                                        
# [6] "AGE"                                                         
# [7] "WANPLUM"                                                     
# [8] "PLPHASE"                                                     
# [9] "SEX"                                                         
# [10] "COUNT"                                                       
# [11] "NFEED"                                                       
# [12] "OCFEED"                                                      
# [13] "NSOW"                                                        
# [14] "OCSOW"                                                       
# [15] "NSOICE"                                                      
# [16] "OCSOICE"                                                     
# [17] "OCSOSHP"                                                     
# [18] "OCINHD"                                                      
# [19] "NFLYP"                                                       
# [20] "OCFLYP"                                                      
# [21] "NACC"                                                        
# [22] "OCACC"                                                       
# [23] "NFOLL"                                                       
# [24] "OCFOL"                                                       
# [25] "OCMOULT"                                                     
# [26] "OCNATFED"

#Clean column names

seabirds_data_clean <- left_join(
  seabirds_ship_data, 
  seabirds_bird_data, 
  by = "RECORD ID") %>% 
  clean_names() 

#Writes/creates cleaned CSV file

write_csv(seabirds_data_clean, "../clean_data/seabird_data_clean.csv")


# seabirds_data_clean_trial <- " "
# 
# for (col_name_ in names(seabirds_data_clean)) {
#   if (length(unique(seabirds_data_clean$col_name_)) == 1){
#     seabirds_data_clean_trial <- select(seabirds_data_clean, (-col_name_))
#   }
# }

names(seabirds_data_clean)
# [1] "record_x"                                           
# [2] "record_id"                                          
# [3] "date"                                               
# [4] "time"                                               
# [5] "lat"                                                
# [6] "long"                                               
# [7] "ew"                                                 
# [8] "sact"                                               
# [9] "speed"                                              
# [10] "sdir"                                               
# [11] "cld"                                                
# [12] "prec"                                               
# [13] "wspeed"                                             
# [14] "wdir"                                               
# [15] "atmp"                                               
# [16] "aprs"                                               
# [17] "sste"                                               
# [18] "stmp"                                               
# [19] "sal"                                                
# [20] "depth"                                              
# [21] "obs"                                                
# [22] "csmeth"                                             
# [23] "month"                                              
# [24] "seasn"                                              
# [25] "long360"                                            
# [26] "latcell"                                            
# [27] "longecell"                                          
# [28] "record_y"                                           
# [29] "species_common_name_taxon_age_sex_plumage_phase"    
# [30] "species_scientific_name_taxon_age_sex_plumage_phase"
# [31] "species_abbreviation"                               
# [32] "age"                                                
# [33] "wanplum"                                            
# [34] "plphase"                                            
# [35] "sex"                                                
# [36] "count"                                              
# [37] "nfeed"                                              
# [38] "ocfeed"                                             
# [39] "nsow"                                               
# [40] "ocsow"                                              
# [41] "nsoice"                                             
# [42] "ocsoice"                                            
# [43] "ocsoshp"                                            
# [44] "ocinhd"                                             
# [45] "nflyp"                                              
# [46] "ocflyp"                                             
# [47] "nacc"                                               
# [48] "ocacc"                                              
# [49] "nfoll"                                              
# [50] "ocfol"                                              
# [51] "ocmoult"                                            
# [52] "ocnatfed"  

#checks whether a column has unique values, 
#if just one value is present the column should be dropped

# unique(seabirds_data_clean$sdir)

#The 52 columns were checked via console and there are no columns with just one observation
#NA and TRUe were considered as two different observations

#For deleting just NA columns

#trial <- seabirds_data_clean[, colSums(is.na(seabirds_data_clean)) != nrow(seabirds_data_clean)]

#There are none just NA columns
