library('glmnet')
set.seed(156)
health <- read.csv("mental_health.csv")

train_ids <- sample(1:nrow(health), floor(0.8*nrow(health)))
train <- health[ train_ids,]
test  <- health[-train_ids,]

y.train <- train$IsMentalHealthRelated
x.train <- model.matrix(IsMentalHealthRelated ~ .,train)[,-1]
x.test  <- model.matrix(IsMentalHealthRelated ~ .,test)[,-1]


cv2  <- cv.glmnet(x.train,y.train,alpha=0, family="binomial", nfolds = 10)
cv3  <- cv.glmnet(x.train,y.train,alpha=1, family="binomial", nfolds = 10)

fit1 <- glm(IsMentalHealthRelated ~ .,data= train, family="binomial")
fit2 <- glmnet(x.train,y.train,alpha=0,family="binomial", lambda = cv2$lambda.min)
fit3 <- glmnet(x.train,y.train,alpha=1,family="binomial", lambda = cv3$lambda.min)

pred1 <- predict(fit1,test,type = "response") > 0.5

pred2 <- predict(fit2,x.test,type = "response") > 0.5
pred3 <- predict(fit3,x.test,type = "response") > 0.5


cat("Accuracy of plain logistic model: ",mean(pred1 == (test$IsMentalHealthRelated==1))*100)
cat("Accuracy of Ridge logistic model: ",mean(pred2 == (test$IsMentalHealthRelated==1))*100)
cat("Accuracy of Lasso logistic model: ",mean(pred3 == (test$IsMentalHealthRelated==1))*100)

cat("Weights of Ridge model")
sort(coef(fit2)[,1],decreasing = TRUE)

cat("Weights of Lasso model")
sort(coef(fit3)[,1],decreasing = TRUE)

#The results are sensible as the classifiers predict that the inclusion of words such as counsel, term, anxiety, university, mental.health, worry, fine and service 
#(first 4 highly weighted words of ridge and lasso models) show a high probability that the reddit post is related to mental health.