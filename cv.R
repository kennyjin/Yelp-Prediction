rm(list = ls())
data<-read.csv("yelp_train_combined_2000.csv")
yelp<-read.csv("Yelp_train.csv")
yelp.test<-read.csv("yelp_out_combined_2000.csv")
yelp_test <- read.csv("Yelp_test.csv")
yelp_validate <- read.csv("Yelp_validate.csv")
yelp_out <- rbind(yelp_test,yelp_validate)

data$X<-NULL
yelp.test$X<-NULL
data<-data.frame(data, yelp$stars)
set.seed(87)
train<-sample(nrow(data), 0.7*nrow(data),replace = FALSE)
yelp.train<-data[train,]
yelp.test<-data[-train,]

install.packages("irlba")#svd
install.packages("e1071")#k-fold cv
install.packages("rpart")

library(irlba)
library(e1071)
library(rpart)
library(caret)

# Define training control
set.seed(123) 
train.control <- trainControl(method = "cv", number = 10)
# Train the model
model.1<- train(yelp.stars ~., data = yelp.train, method = "lm",trControl = train.control)
model.2<- train(yelp.stars ~., data = yelp.train, method = "rpart", trControl = train.control)

print(model.1)
print(model.2)

prediction1 <- predict(model.1, yelp.test, OOB=TRUE, type = "response")
prediction2 <- predict(model.2, yelp.test, OOB=TRUE, type = "response")

submit1 <- data.frame(Id = yelp_out$Id, Expected = prediction1)
submit2 <- data.frame(Id = yelp_out$Id, Expected = prediction2)
write.csv(submit1, file = "predictCV1.csv",row.names = FALSE)
write.csv(submit2 , file = "predictCV2.csv",row.names = FALSE)
