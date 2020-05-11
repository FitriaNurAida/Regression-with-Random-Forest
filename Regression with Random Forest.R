# Import Data #
movie <- read.csv("E:/My Dictionary/Using R/Data/Movie_regression.csv")
View(movie)

# Data Preprocessing #
summary(movie) #there are missing values in variable Time_taken
movie$Time_taken[is.na(movie$Time_taken)] <- mean(movie$Time_taken,na.rm = TRUE)

# Test-Train Split
install.packages('caTools')
library(caTools)
set.seed(0)
split <- sample.split(movie,SplitRatio = 0.8)
train <- subset(movie,split == TRUE)
test <- subset(movie,split == FALSE)

############################### MODELING #################################
install.packages("randomForest")
library(randomForest)
set.seed(0)
rf <- randomForest(formula = Collection~., data = train, ntree=500)
test$pred <- predict(rf, test)
RMSE <- sqrt(mean((test$pred-test$Collection)^2))
RMSE
