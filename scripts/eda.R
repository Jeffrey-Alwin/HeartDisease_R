
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

# scripts/eda.R
library(ggplot2)
df_clean <- readRDS("data/df_clean.rds")

# Summary statistics
write.csv(summary(df_clean), "data/summary_stats.csv")

# Target distribution
ggplot(df_clean, aes(x = as.factor(target))) +
  geom_bar() + ggtitle("Target distribution") + xlab("target") -> p1
ggsave("data/target_distribution.png", p1, width = 6, height = 4)

# Correlation plot for numeric variables
num_df <- df_clean %>% select(where(is.numeric))
if (ncol(num_df) > 1) {
  cor_mat <- cor(num_df, use = "pairwise.complete.obs")
  png("data/correlation_matrix.png", width = 800, height = 800)
  corrplot::corrplot(cor_mat, method = "color", tl.cex=0.7)
  dev.off()
}
