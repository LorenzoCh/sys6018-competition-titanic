library(tidyverse)
library(readr)
library(dplyr)

train = read_csv("train.csv")
test=read_csv("test.csv")
test[c(2,4,11)]<-lapply(test[c(2,4,11)],as.factor)
train[c(2,3,5,12)]<-lapply(train[c(2,3,5,12)],as.factor)

predict.lg <- glm(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked, data=train, family = "binomial")
summary(predict.lg)
probs<-as.vector(predict(predict.lg,newdata=test, type="response"))
preds <- rep(0,418) 
preds[probs>0.5] <- 1
result<-data.frame("Passengerid"<-test$PassengerId,"'Survived'"<-preds)

write.table(result, file = "result.csv", row.names=F,sep=",")
