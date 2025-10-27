
# Auto-generated R project script
# Dataset: 17a3bd4d-02ce-4900-a989-a8a31e98e669.csv
# Rows: 5000, Columns: 14
# Detected target column: 'target'
# Problem type: regression

library(tidyverse)
library(caret)
library(recipes)
library(randomForest)
set.seed(123)

# scripts/data_cleaning.R
data_path <- "data/17a3bd4d-02ce-4900-a989-a8a31e98e669.csv"
df <- read.csv(data_path, stringsAsFactors = FALSE)

# Basic cleaning steps:
# 1. Trim whitespace from character columns
df <- df %>% mutate(across(where(is.character), ~str_trim(.)))

# 2. Convert logical-looking columns to factor
# 3. Impute missing values with median (numeric) and mode (categorical) using recipes
rec <- recipe(~ ., data = df) %>%
  step_string2factor(all_nominal_predictors()) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors())


prepped <- prep(rec, training = df)
df_clean <- bake(prepped, df)

saveRDS(df_clean, "data/df_clean.rds")
glimpse(df_clean)
summary(df_clean)
