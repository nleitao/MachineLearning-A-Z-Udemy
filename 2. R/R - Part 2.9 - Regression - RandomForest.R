#Random Forest Regression

dataset=read.csv('Position_Salaries.csv')
dataset=dataset[2:3]

#install.packages('randomForest')
library(randomForest)

#Fitting Random Forest Regression to the dataset
#dataset[1] -> returns a dataframe BUT dataset$Salary -> returns a vector..crazy right?
set.seed(1234)
regressor=randomForest(x=dataset[1],
                y=dataset$Salary,
                ntree=500)


#Visualising the SVR results
#install.packages('ggplot2')
library(ggplot2)

x_grid=seq(min(dataset$Level),max(dataset$Level),0.01)

ggplot()+
  geom_point(aes(x=dataset$Level ,y=dataset$Salary),
             colour='red') +
  geom_line(aes(x=x_grid,y=predict(regressor,newdata = data.frame(Level= x_grid))),
            colour='blue') +
  ggtitle('Truth or bluff (Random Forest)') +
  xlab('Level')+
  ylab('Salary')


#Predicting a new result with Linear Regression
y_pred=predict(regressor,data.frame(Level=6.5))

