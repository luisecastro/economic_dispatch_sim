library(shiny)
library(markdown)
library(dplyr)
library(ggplot2)
library(reshape2)

load("data.RData")
load("demand.RData")

eco_disp <- function(cs,pt){
    ptt <- pt
    dcs <- cs[,-4]
    dcs$a <- 2*dcs$a
    temp <- NULL
    repeat{
        lambda <- (sum(dcs$b/dcs$a)+pt)/sum(dcs$a^-1)
        p <- round((lambda-dcs$b)/dcs$a)
        less <- which(p<dcs$p.min)
        more <- which(p>dcs$p.max)
        
        if(length(less)!=0){
            pt <- pt-sum(dcs$p.min[less])
            temp <- rbind(temp,cbind(cs[less,],power=dcs$p.min[less]))
        }
        
        if(length(more)!=0){
            pt <- pt-sum(dcs$p.max[more])
            temp <- rbind(temp,cbind(cs[more,],power=dcs$p.max[more]))
        }
        flag <- length(less)==0 & length(more)==0
        if(!flag) dcs <- dcs[-c(less,more),]
        if(!flag) cs <- cs[-c(less,more),]
        if(flag) break
    }
    temp <- rbind(temp,cbind(cs,power=p))
    temp$cost <- temp$a*temp$power^2+temp$b*temp$power+temp$k
    temp$rate <- temp$cost/temp$power
    temp$ci <- 2*temp$a*temp$power+temp$b
    temp$power <- round(temp$power)
    temp$cost <- round(temp$cost)
    temp$rate <- round(temp$rate)
    temp$ci <- round(temp$ci)
    temp
}

loader <- function(load=900,step=50){
    for(i in 1:23) load <- c(load,load[i]+
                                 sample(c(-2,-1,0,1,2),1,replace=T)*step)
    
    load <- data.frame(load=load,hour=1:24)
    load
}

profile <- function(cs,load){
    temp <- eco_disp(cs,load[1])[,c(1,7)]
    for(i in 2:length(load)) temp <- cbind(temp,eco_disp(cs,load[i])[,7])
    names(temp) <- c("names",seq(1,length(load),by=1))
    temp <- melt(temp)
    names(temp) <- c("names","hour","power")
    temp
}
