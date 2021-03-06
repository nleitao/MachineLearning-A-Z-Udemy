#KNN Classification

#importing the dataset
dataset=read.csv('Social_Network_Ads.csv')

#we will only train the model taking into consideration the age and the salary
dataset=dataset[3:5]

#Encoding the target feature as factor
#I think it's redundant... because it's already 0 and 1
dataset$Purchased=factor(dataset$Purchased,levels=c(0,1))

library(caTools)
set.seed(123)
split=sample.split(dataset$Purchased,SplitRatio = 0.75)
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

#feature scaling
training_set[-3]=scale(training_set[-3])
test_set[-3]=scale(test_set[-3])

#Fitting KNN Classification to the training set AND predicting the test set result (in the same go)
library(class)

#I have to input the training set without the y vector/dependent variable (this will be input in parameter cl)
y_pred= knn(train=training_set[,-3],
           test=test_set[,-3],
           cl=training_set[,3],
           k=5)

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

y_grid=knn(train=training_set[,-3],
           test=grid_set[,-3],
           cl=training_set[,3],
           k=5)

plot(set[,-3],
     main="KNN Classification (Training Set)",
     xlan="Age",ylab = "Estimated Salary",
     xlim=range(X1),ylim=range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add=TRUE)
points(grid_set,pch='.',col=ifelse(y_grid==1,'springgreen3','tomato'))
points(set,pch=21,bg=ifelse(set[,3]==1,'green4','red3'))


#### Try to visualise the test set

#Visualising the test set result
install.packages('ElemStatLearn')
library(ElemStatLearn)
set=test_set
X1=seq(min(set[,1])-1,max(set[,1])+1, by =0.01)
X2=seq(min(set[,2])-1,max(set[,2])+1, by =0.01)
grid_set=expand.grid(X1,X2)
colnames(grid_set)=c('Age','EstimatedSalary')

y_grid=knn(train=training_set[,-3],
           test=grid_set[,-3],
           cl=training_set[,3],
           k=5)

plot(set[,-3],
     main="KNN Classification (Test Set)",
     xlan="Age",ylab = "Estimated Salary",
     xlim=range(X1),ylim=range(X2))
contour(X1,X2,matrix(as.numeric(y_grid),length(X1),length(X2)),add=TRUE)
points(grid_set,pch='.',col=ifelse(y_grid==1,'springgreen3','tomato'))
points(set,pch=21,bg=ifelse(set[,3]==1,'green4','red3'))

