# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('Salary_Data.csv')

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#Fitting Simple Linear Regression to the training set
#que e so usar a funcao lm e la dentro temos que indicar a
#dependent variable described as a combination of the independent variable (the salary is proportional asto the years of experience)
#e tb onde esta esta informacao (em que data set)
regressor=lm(formula=Salary ~ YearsExperience,
             data=training_set)

#Predicting the test set results. usar a funcao predict e la dentro por o regressor que foi criado, e por o novo dataset que quero que seja aplicado ao regressor
y_pred=predict(regressor,newdata=test_set)

#Visualising the training set results
#installing the plotting library. only need to do this once obviously
install.packages('ggplot2')

#import library
library(ggplot2)

ggplot()+
  geom_point(aes(x=training_set$YearsExperience, y=training_set$Salary),
             color='red') +
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor,newdata=training_set)),
            color='blue') +
  ggtitle('Salary vs Experience (Training Set)') +
  xlab('Years of Experience')+
  ylab('Salary')


#Visualising the training set results
ggplot()+
  geom_point(aes(x=test_set$YearsExperience, y=test_set$Salary),
             color='red') +
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor,newdata=training_set)),
            color='blue') +
  ggtitle('Salary vs Experience (Test Set)') +
  xlab('Years of Experience')+
  ylab('Salary')
