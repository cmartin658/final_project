library(tidyverse)
library(readr)
library(dplyr)
library(janitor)
library(readxl)

# REMOVING AND RENAMING COLUMNS

table_2002_2015 <- A1_4_2002_2015 %>%
  select(-c(10,12,13,14,16,17,18,20,21,22,24,25,26,28,29,30)) %>%
  
  rename("30-Jun-02" = "...2",
         "30-Jun-03" = "...3",
         "30-Jun-04" = "...4",
         "30-Jun-05" = "...5",
         "30-Jun-06" = "...6",
         "30-Jun-07" = "...7",
         "30-Jun-08" = "...8",
         "30-Jun-09" = "...9",
         "30-Jun-10" = "...11",
         "30-Jun-11" = "...15",
         "30-Jun-12" = "...19",
         "30-Jun-13" = "...23",
         "30-Jun-14" = "...27",
         "30-Jun-15" = "Contents") %>%
  rename_at(1, ~"Type")

table_2015_2023 <- A1_4_2015_2023 %>%
  select(1,2,6,10,14,18,22,26,30,34) %>%
  
  rename_at(1, ~"Type") %>%
  rename("30-Jun-15" = "...2",
         "30-Jun-16" = "...6",
         "30-Jun-17" = "...10",
         "30-Jun-18" = "...14",
         "30-Jun-19" = "...18",
         "30-Jun-20" = "...22",
         "30-Jun-21" = "...26",
         "30-Jun-22" = "...30",
         "30-Jun-23" = "Contents")


# SLICING - USED 

early_adults <- table_2002_2015 %>%
  slice(14:23)

early_18_20 <- table_2002_2015 %>%
  slice(24:34)

early_15_17 <- table_2002_2015 %>%
  slice(35:45)

later_adults <- table_2015_2023 %>%
  slice(17:29)

later_18_20 <- table_2015_2023 %>%
  slice(31:43)

later_15_17 <- table_2015_2023 %>%
  slice(45:57)


# PIVOTING - USED

pivot_2002 <- early_adults %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )

pivot_2015 <- later_adults %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )

pivot_2015 <- pivot_2015 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  )
  
pivot_2015 <- pivot_2015 %>%
  clean_names()
  mutate(other_offences = criminal_damage_and_arson + possession_of_weapons + public_order_offences + miscellaneous_crimes_against_society + summary_non_motoring) %>%
  select(Type, violence_against_the_person, sexual_offences, robbery, theft_offences, drug_offences, fraud_offences, summary_motoring, offence_not_recorded)
