#Polynomial Regression

dataset=read.csv('Position_Salaries.csv')
dataset=dataset[2:3]

X=dataset$Level 
y=dataset$Salary

#Fitting Linear Regression to the dataset
lin_reg=lm(formula = Salary ~ .,
           data=dataset)

#Fitting Polynomial Regression to the dataset

#crio colunas adicionais com o . sei la eu... elevo as variaveis independentes a varios graus. mas nao sei bem porque...
dataset$Level2=dataset$Level^2
dataset$Level3=dataset$Level^3

poly_reg=lm(formula = Salary ~ .,
            data=dataset)


#Visualising the linear results
#install.packages('ggplot2')
library(ggplot2)

ggplot()+
  geom_point(aes(x=X,y=y),
             colour='red') +
  geom_line(aes(x=X,y=predict(lin_reg,newdata = dataset)),
            colour='blue') +
  ggtitle('Truth or bluff (linear regression') +
  xlab('Level')+
  ylab('Salary')

#Visualising polynomial regression
ggplot()+
  geom_point(aes(x=X,y=y),
             colour='red') +
  geom_line(aes(x=X,y=predict(poly_reg,newdata = dataset)),
            colour='blue') +
  ggtitle('Truth or bluff (Polynomial regression') +
  xlab('Level')+
  ylab('Salary')

#Predicting a new result with Linear Regression
y_pred=predict(lin_reg,newdata = data.frame(Level=6.5))

#Predicting a new result with Polynomial Regression
#temos que por o valor que queremos prever, neste caso 6.5, elevado a 1, elevado a 2, elevado a 3.. etc
y_pred=predict(poly_reg,newdata = data.frame(Level=6.5,Level2=6.5^2,Level3=6.5^3))