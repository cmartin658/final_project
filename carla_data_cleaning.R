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

# DROP 2015 IN EARLY COLUMN (added after)
table_2002_2015 <- table_2002_2015 %>%
  mutate(`30-Jun-15`=NULL)

# SLICING - COMPLETE 

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


# PIVOTING 

#ADULTS 

pivot_2002 <- early_adults %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )
pivot_2002 <- pivot_2002 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  ) %>%
  clean_names()

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

# 18-20
# need to sort out 30-jun-15 column as its a character
# drop because we already have data for 2015

pivot_2002_18_20 <- early_18_20 %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )
pivot_2002_18_20 <- pivot_2002_18_20 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  ) %>%
  clean_names() %>%
  mutate(x18_20_year_olds = NULL)

pivot_2015_18_20 <- later_18_20 %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )
pivot_2015_18_20 <- pivot_2015_18_20 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  ) %>%
  clean_names()

# 15-17

pivot_2002_15_17 <- early_15_17 %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )
pivot_2002_15_17 <- pivot_2002_15_17 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  ) %>%
  clean_names() %>%
  mutate(x15_17_year_olds = NULL)
  
pivot_2015_15_17 <- later_15_17 %>%
  pivot_longer(
    cols = c(-"Type"),
    names_to = "date",
    values_to = "numconvicts"
  )
pivot_2015_15_17 <- pivot_2015_15_17 %>%
  pivot_wider(
    names_from = "Type",
    values_from = "numconvicts"
  ) %>%
  clean_names()

# COMBINE COLUMNS

# ADULTS
pivot_2015_combined_cols <- pivot_2015 %>%
  mutate(other_offences = criminal_damage_and_arson + possession_of_weapons + public_order_offences + miscellaneous_crimes_against_society + summary_non_motoring,
         motoring_offences = summary_non_motoring) %>%
  select(date, violence_against_the_person, sexual_offences, robbery, theft_offences, drug_offences, fraud_offences, motoring_offences, other_offences, offence_not_recorded) %>%
  select(order(colnames(pivot_2015_combined_cols)))

pivot_2002_combined_cols <- pivot_2002 %>%
  mutate(theft_offences = burglary + theft_and_handling,
         fraud_offences = fraud_and_forgery) %>%
  select(-c(burglary, theft_and_handling, fraud_and_forgery)) %>%
  select(order(colnames(pivot_2002_combined_cols)))

# 18-20
pivot_2015_18_20_combined_cols <- pivot_2015_18_20 %>%
  mutate(other_offences = criminal_damage_and_arson + possession_of_weapons + public_order_offences + miscellaneous_crimes_against_society + summary_non_motoring,
         motoring_offences = summary_non_motoring) %>%
  select(date, violence_against_the_person, sexual_offences, robbery, theft_offences, drug_offences, fraud_offences, motoring_offences, other_offences, offence_not_recorded) 

pivot_2002_18_20_combined_cols <- pivot_2002_18_20 %>%
  mutate(theft_offences = burglary + theft_and_handling,
         fraud_offences = fraud_and_forgery) %>%
  select(-c(burglary, theft_and_handling, fraud_and_forgery))

# 15-17
pivot_2015_15_17_combined_cols <- pivot_2015_15_17 %>%
  mutate(other_offences = criminal_damage_and_arson + possession_of_weapons + public_order_offences + miscellaneous_crimes_against_society + summary_non_motoring,
         motoring_offences = summary_non_motoring) %>%
  select(date, violence_against_the_person, sexual_offences, robbery, theft_offences, drug_offences, fraud_offences, motoring_offences, other_offences, offence_not_recorded)

pivot_2002_15_17_combined_cols <- pivot_2002_15_17 %>%
  mutate(theft_offences = burglary + theft_and_handling,
         fraud_offences = fraud_and_forgery) %>%
  select(-c(burglary, theft_and_handling, fraud_and_forgery))

# JOIN TABLES 

adults <- full_join(x = pivot_2002_combined_cols,
          y = pivot_2015_combined_cols)

table_18_20 <- full_join(x = pivot_2002_18_20_combined_cols,
                         y = pivot_2015_18_20_combined_cols)

table_15_17 <- full_join(x = pivot_2002_15_17_combined_cols,
                         y = pivot_2015_15_17_combined_cols)
