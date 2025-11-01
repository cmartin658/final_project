library(tidyverse)
library(readr)
library(dplyr)
library(janitor)
library(readxl)

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

