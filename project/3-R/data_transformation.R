setwd("~/Desktop/1 semestras/Didziuju duomeni rinkybos metodai/Projektas")
library(tidyverse)
library(readr)
data <- read_csv("1-sample_data.csv")
select(data,y)
data_additional2 <- read_csv("2-additional_data.csv")
data_additional3 <- read_csv("3-additional_features.csv")
joined_data <- union(data, data_additional2)
data_full <-joined_data %>% 
  inner_join(data_additional3, by = "id")

write_csv(data_full, "train_data.csv")
### save combined file into 1-data directory