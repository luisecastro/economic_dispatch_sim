rm(list=ls())
days <- NULL
hours <- NULL
for(i in 1:365) {
    days <- c(days,rep(i,24))
    hours <- c(hours,0:23)
}

demand <- data.frame(days=days,hours=hours)
demand$weekdays <- c(rep(c(rep("mon",24),
                           rep("tue",24),
                           rep("wed",24),
                           rep("thu",24),
                           rep("fri",24),
                           rep("sat",24),
                           rep("sun",24)),52),
                           rep("mon",24))

demand$weekdaysN <- c(rep(c(rep(1,24),
                           rep(2,24),
                           rep(3,24),
                           rep(4,24),
                           rep(5,24),
                           rep(6,24),
                           rep(7,24)),52),
                            rep(1,24))


demand$months <- c(rep("jan",31*24),
                   rep("feb",28*24),
                   rep("mar",31*24),
                   rep("apr",30*24),
                   rep("may",31*24),
                   rep("jun",30*24),
                   rep("jul",31*24),
                   rep("ago",31*24),
                   rep("sep",30*24),
                   rep("oct",31*24),
                   rep("nov",30*24),
                   rep("dec",31*24))

demand$monthsN <- c(rep(1,31*24),
                   rep(2,28*24),
                   rep(3,31*24),
                   rep(4,30*24),
                   rep(5,31*24),
                   rep(6,30*24),
                   rep(7,31*24),
                   rep(8,31*24),
                   rep(9,30*24),
                   rep(10,31*24),
                   rep(11,30*24),
                   rep(12,31*24))


demand$weekdays <- as.factor(demand$weekdays)
demand$months <- as.factor(demand$months)
summary(demand)

cosd <- function(x) cos(2*pi*(x/360))
sind <- function(x) sin(2*pi*(x/360))

demand$temp <- -5*cosd(demand$days)-4*cosd((360*demand$hours/24))+10+rnorm(8760,mean=1,sd=1)
demand$demand <- ifelse(demand$monthsN==12,50,ifelse(demand$monthsN==1,150,100))+ifelse(demand$weekdaysN<6,100,20)+(demand$temp+5)^2

demand$hoursN <- demand$hours
demand$hours <- as.factor(demand$hours)

summary(demand)

save(demand,file="demand.RData")


lm.fit <- lm(demand~.,data=demand)
summary(lm.fit)

lm.fit1 <- lm(demand~.-hoursN-monthsN-weekdaysN-days,data=demand)
summary(lm.fit1)
demand$lm1 <- predict(lm.fit1,demand)
demand$lm2 <- predict(lm.fit2,demand)
head(demand)
plot(demand$demand,demand$lm1)


lm.fit2 <- lm(demand~hours+weekdays+months+temp+I(temp^2),data=demand)
summary(lm.fit2)
lm.pred2 <- predict(lm.fit2,demand)
demand <- demand[,-11]
plot(demand$demand,lm.pred2)
plot(lm.pred2)

