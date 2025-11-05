library(tidyverse)
library(readr)
library(dplyr)
library(janitor)
library(readxl)

# REMOVING COLUMNS

table_2002_2015 <- A1_4_2002_2015 %>%
  select(-c(10,11,12,13,15,16,17,19,20,21,23,24,25,27,28,29)) %>%
  rename("30-Jun-02" = "...2",
         "30-Jun-03" = "...3",
         "30-Jun-04" = "...4",
         "30-Jun-05" = "...5",
         "30-Jun-06" = "...6",
         "30-Jun-07" = "...7",
         "30-Jun-08" = "...8",
         "30-Jun-09" = "...9",
         "30-Jun-10" = "...10",
         "30-Jun-06" = "...6",)


early_crimes <- read_xlsx("data/A1.4_2002-2015.xlsx",
                          
                          col_names = c("Type", "30-Jun-02", "30-Jun-03",
                                        "30-Jun-04", "30-Jun-05", "30-Jun-06",
                                        "30-Jun-07", "30-Jun-08", "30-Jun-09",
                                        "30-Jun-09(1)",
                                        "30-Jun-10", "30-Sep-10", "31-Dec-10", "31-Mar-11", 
                                        "30-Jun-11", "30-Sep-11", "31-Dec-11", "31-Mar-12", 
                                        "30-Jun-12", "30-Sep-12", "31-Dec-12", "31-Mar-13",
                                        "30-Jun-13", "30-Sep-13", "31-Dec-13", "31-Mar-14",
                                        "30-Jun-14", "30-Sep-14", "31-Dec-14", "31-Mar-15",
                                        "30-Jun-15"))



# SELECTING DATA

early_crimes <- A1_4_2002_2015 %>%
  slice(13:45)

late_crimes <- A1_4_2015_2023 %>%
  slice(16:57)

# REMNAME COLUMNS

early_crimes <- read_xlsx("data/A1.4_2002-2015.xlsx",
                          col_names = c("Type", "30-Jun-02", "30-Jun-03",
                                        "30-Jun-04", "30-Jun-05", "30-Jun-06",
                                        "30-Jun-07", "30-Jun-08", "30-Jun-09",
                                        "30-Jun-09(1)", "30-Jun-10", "30-Jun-11",
                                        "30-Jun-12", "30-Jun-13", "30-Jun-14", "30-Jun-15"))



early_adults <- A1_4_2002_2015 %>%
  slice(13:23)

early_18_20 <- A1_4_2002_2015 %>%
  slice(24:34)

early_15_17 <- A1_4_2002_2015 %>%
  slice(35:45)

