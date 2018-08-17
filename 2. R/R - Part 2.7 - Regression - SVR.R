#SVR Regression

dataset=read.csv('Position_Salaries.csv')
dataset=dataset[2:3]

#X=dataset$Level 
#y=dataset$Salary

#install.packages('e1071')
library(e1071)

#Fitting SVR Regression to the dataset
regressor=svm(formula = Salary ~ .,
              data=dataset,
              type='eps-regression')


#Visualising the SVR results
#install.packages('ggplot2')
library(ggplot2)

ggplot()+
  geom_point(aes(x=dataset$Level ,y=dataset$Salary),
             colour='red') +
  geom_line(aes(x=dataset$Level,y=predict(regressor,newdata = dataset)),
            colour='blue') +
  ggtitle('Truth or bluff (SVR)') +
  xlab('Level')+
  ylab('Salary')


#Predicting a new result with Linear Regression
y_pred=predict(regressor,data.frame(Level=6.5))

