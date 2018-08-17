#Logistic Regression

#importing the dataset
dataset=read.csv('Social_Network_Ads.csv')

#we will only train the model taking into consideration the age and the salary
dataset=dataset[,3:5]

library(caTools)
set.seed(123)
split=sample.split(dataset$Purchased,SplitRatio = 0.75)
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

training_set[,1:2]=scale(training_set[,1:2])
test_set[,1:2]=scale(test_set[,1:2])

#Logistic Regression

#importing the dataset
dataset=read.csv('Social_Network_Ads.csv')

#we will only train the model taking into consideration the age and the salary
dataset=dataset[,3:5]

library(caTools)
set.seed(123)
split=sample.split(dataset$Purchased,SplitRatio = 0.75)
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

training_set[,1:2]=scale(training_set[,1:2])
test_set[,1:2]=scale(test_set[,1:2])

#Fitting Logistic Regression to the training set
classifier=glm(formula=Purchased ~ .,
               family=binomial,
               data=training_set)

#Predicting the Test set results
prob_pred=predict(classifier, 
                  type='response',
                  newdata = test_set)

#conversion: if the probability is greater than 0.5 counts as 1.
#com isto estamos a tornar a regressao num classifier
y_pred=ifelse(prob_pred>0.5,1,0)

#Making the confusion matrix
cm=table(test_set[,3],y_pred)

#Visualising the training set result
install.packages('ElemStatLearn')
library(ElemStatLearn)
set=training_set
X1=seq(min(set[,1])-1,max(set[,1])+1, by =0.01)
X2=seq(min(set[,2])-1,max(set[,2])+1, by =0.01)
grid_set=expand.grid(X1,X2)
colnames(grid_set)=c('Age','EstimatedSalary')
prob_set=predict(classifier,type='response',newdata = grid_set)
y_grid=ifelse(prob_set>0.5,1,0)
plot(set[,-3],
     main="Logistic Regression (Training Set)",
     xlan="Age",ylab = "Estimated Salary",
     xlim=range(X1),ylim=range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add=TRUE)
points(grid_set,pch='.',col=ifelse(y_grid==1,'springgreen3','tomato'))
points(set,pch=21,bg=ifelse(set[,3]==1,'green4','red3'))
