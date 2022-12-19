library(h2o)
library(tidyverse)
h2o.init()

df <- h2o.importFile("train_data.csv")
df
class(df)
summary(df)

y<-"y"
x <- setdiff(names(df), c(y, "id"))
df$y<- as.factor(df$y)
summary(df)

splits <- h2o.splitFrame(df, c(0.6,0.2), seed=123)
train <- h2o.assign(splits[[1]], "train")
valid <- h2o.assign(splits[[2]], "valid")
test <- h2o.assign(splits[[3]], "test")
aml<- h2o.automl(x=x,
                 y=y, 
                 training_frame = train, 
                 validation_frame = valid,
                 max_runtime_secs = 3000)
aml@leaderboard
#auc, 
model <-aml@leader

h2o.auc(perf_train)

test_data <- h2o.importFile("test_data.csv")

h2o.saveModel(model, "KTU-DVDA-PROJECT-main/project/4-model/", filename = "my_model0.83")

#modelis
model4 <- h2o.loadModel("KTU-DVDA-PROJECT-main/project/4-model/my_model0.83")

#train= 0.85, validation= 0.832, test= 0.832
perf_train <- h2o.performance(model4, train = TRUE)
perf_train
perf_valid <- h2o.performance(model4, valid = TRUE)
perf_valid
perf_test <- h2o.performance(model4, newdata = test)
perf_test
predictions <- h2o.predict(model4, test_data)
predictions 

predictions %>%
  as_tibble() %>%
  mutate(id = row_number(), y = p0) %>% 
  select(id, y) %>%
  write_csv("KTU-DVDA-PROJECT-main/project/5-predictions/predictions_test_KG.csv")
h2o.shutdown()