
# R ML Project 
Dataset: 17a3bd4d-02ce-4900-a989-a8a31e98e669.csv
Rows: 5000, Columns: 14
Detected target column: **target**
Problem type: **classification**

## Structure
- data/ - dataset and outputs (cleaned data, images)
- scripts/ - R scripts to run for each step
- models/ - trained models will be saved here when you run model_building.R

## How to run
1. Open this folder as an RStudio Project (file R_ML_Project.Rproj)
2. Install required packages in R:
   - tidyverse, caret, recipes, randomForest, pROC, corrplot
3. Run scripts in order:
   - `scripts/data_import.R`
   - `scripts/data_cleaning.R`
   - `scripts/eda.R`
   - `scripts/model_building.R`

added visualizations for every feature depicting their importance over the result 
