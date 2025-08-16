data = read.csv(file.choose())
View(data)

attach(data)

library(car)

data = subset(data, select = -c(Company, Industry, Year, X)) 

fit1 = lm(Revenue ~ ., data = data)
summary(fit1)

vif(fit1)

fit2 = update(fit1, Revenue ~.-S_Number.of.Employees..from.CSR.reporting, data = data)
vif(fit2)
summary(fit2)

# Residuals
res = residuals(fit2)

stdres = rstandard(fit2)

max(abs(stdres))
min(abs(stdres))        

# As the standardized value > 3, there exist at least an outlier in the model.
outlierTest(fit2, data = data)

data = data[-c(14, 15), ]

fit3 = update(fit2, data = data)

summary(fit2)        # Original model
summary(fit3)       

outlierTest(fit3)

# Now removed the 2 outliers, that were present in the model.

res = residuals(fit3)

stdres = rstandard(fit3)

max(abs(stdres))
min(abs(stdres))  
residualPlots(fit3)


qqnorm(res)
qqline(res)

# Normality of the residuals needs to be improved.

plot(fitted(fit3), res)

summary(fit3)

# Since p-value < 0.05, there exists a regression b/w the independent variables and Revenue

# CHECKING THE INDIVIDUAL VARIABLE

# Removing the 'E_Electricity.Purchased', since it has the highest p-value.

fit4 = update(fit3, Revenue ~ .-E_Electricity.Purchased, data = data)
summary(fit4)

# Now removing the 'E_Waste.Total'

fit5 = update(fit4, Revenue ~.-E_Waste.Total, data = data)
summary(fit5)

# Now removing the 'G_Total.Senior.Executives.Compensation.To.Revenues.in.million'

fit6 = update(fit5, Revenue ~.-G_Total.Senior.Executives.Compensation.To.Revenues.in.million, data = data)
summary(fit6)

# Now removing the 'S_Women.Employees'
fit7 = update(fit6, Revenue ~.-S_Women.Employees, data = data)
summary(fit7)

# Now removing the 'G_Enterprise.Value.including.Cash.and.ST.Investments.in.USD'
fit8 = update(fit7, Revenue ~.-G_Enterprise.Value.including.Cash.and.ST.Investments.in.USD, data = data)
summary(fit8)



# Model    R2       Adj R2    Difference

# Fit1    0.8336    0.8180    0.0156  
# Fit2    0.8332    0.8185    0.0147
# Fit3    0.8554    0.8425    0.0129
# Fit4    0.8553    0.8432    0.0121
# Fit5    0.8551    0.8439    0.0112 
# Fit6    0.8529    0.8423    0.0106
# Fit7    0.8531    0.8433    0.0098
# Fit8    0.8507    0.8415    0.0092


# Model 8 is having overall significance as well as is having the individual significance as well.

res<-residuals(fit8)
stdres<-rstandard(fit8)

max(abs(rstandard(fit8)))
min(abs(rstandard(fit8)))

plot(fitted(fit8), res)

qqnorm(res)
qqline(res)

# The fitted model 8 can conclude that the 85% of the variability in the Revenue can be explained by the 
# model 8.

bwd_model = step(fit3,  direction = "backward", scope = formula(~ .))

summary(bwd_model)
