library(ggplot2)
df_clean <- readRDS("data/df_clean.rds")
ggplot(df_clean, aes(x = as.factor(target))) +
  geom_bar(fill = "steelblue") +
  ggtitle("Target Distribution")
