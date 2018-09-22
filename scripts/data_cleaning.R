library(tidyverse)
library(tidycensus)
library(janitor)
library(viridis)
library(broom)

read_csv("data/Opioid_Dispensation_Data_County_Quarter_3_2016_-_Current_Health.csv") %>% 
  clean_names() -> data_dispensation

data_dispensation %>% 
  mutate(county_name = str_c(str_to_title(county_name), " County"),
         county_name = str_replace(county_name, "Mckean", "McKean"),
         time_period = factor(time_period),
         quarter = str_sub(time_period, 6, 7)) -> df_dispensation

levels(df_dispensation$time_period) -> time_period_levels


read_csv("data/Opioid_Seizures_and_Arrests_Year_2013_-_June_2018_County_State_Police.csv") %>% 
  clean_names() -> data_seizures_arrests

data_seizures_arrests %>% 
  mutate(time_period = factor(str_c(year, qtr, sep =" ")), 
         county_name = str_c(str_to_title(county_name), " County"),
         county_name = str_replace(county_name, "Mckean", "McKean")) -> df_seizures_arrests

read_csv("data/Successful_Naloxone_Reversals_by_Law_Enforcement_Years_2014_-_June_2018_County_Drug_and_Alcohol_Program.csv") %>% 
  clean_names() -> data_reversals

data_reversals %>% 
  mutate(county_name = str_c(str_to_title(county_name), " County"),
         county_name = str_replace(county_name, "Mckean", "McKean")) -> df_reversals
