
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

# scripts/model_building.R
library(caret)
library(randomForest)
library(pROC)

df_clean <- readRDS("data/df_clean.rds")
df_clean <- df_clean %>% mutate(target = as.factor(target))

# Split data
train_index <- createDataPartition(df_clean$target, p = 0.8, list = FALSE)
train <- df_clean[train_index, ]
test  <- df_clean[-train_index, ]

# Simple recipe: remove zero-variance and near-zero predictors
rec <- recipe(target ~ ., data = train) %>%
  step_zv(all_predictors()) %>%
  step_nzv(all_predictors()) %>%
  step_dummy(all_nominal_predictors(), -all_outcomes()) %>%
  step_normalize(all_numeric_predictors())

rec_p <- prep(rec, training = train)
train_p <- bake(rec_p, train)
test_p  <- bake(rec_p, test)

# Train models: logistic (glm) and random forest
ctrl <- trainControl(method = "cv", number = 5, classProbs = TRUE, summaryFunction = twoClassSummary, savePredictions = TRUE)

# Make sure target levels are named properly for twoClassSummary
levels(train_p$target) <- make.names(levels(as.factor(train_p$target)))

set.seed(123)
model_rf <- train(target ~ ., data = train_p, method = "rf", trControl = ctrl, metric = "ROC")

model_glm <- train(target ~ ., data = train_p, method = "glm", family = "binomial", trControl = ctrl, metric = "ROC")

# Evaluate on test
pred_rf <- predict(model_rf, test_p, type = "prob")[,2]
roc_rf <- roc(response = test_p$target, predictor = pred_rf)
auc_rf <- auc(roc_rf)

pred_glm <- predict(model_glm, test_p, type = "prob")[,2]
roc_glm <- roc(response = test_p$target, predictor = pred_glm)
auc_glm <- auc(roc_glm)

cat("Random Forest AUC:", auc_rf, "\n")
cat("GLM AUC:", auc_glm, "\n")

saveRDS(model_rf, "models/model_rf.rds")
saveRDS(model_glm, "models/model_glm.rds")
