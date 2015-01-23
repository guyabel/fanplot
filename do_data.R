##
##cpi data frame
##

library("xlsx")
cpi<-read.xlsx("./data/consumerpriceinflationdetailedreferencetables_tcm77-331413-1.xls", sheetName="Table 6a, 6b, 6c ", startRow=32, stringsAsFactors=FALSE)
cpi[,1]<-NULL
cpi[,2]<-NULL
cpi<-cpi[2:18,]
cpi<-cpi[,-1]
cpi<-cpi[,-13]
cpi<-data.matrix(cpi)
mn <- month.abb[seq(2, 11, 3)]
cpi <- cpi[, paste0("X.",mn)]
cpi<-c(t(cpi))
cpi<-cpi[!is.na(cpi)]
# covert to ts
cpi <- ts(cpi, start = 1997, frequency = 4)
save(cpi,file = "./data/cpi.RData")


##
##boe data frame
##
# read in boe historical data
library("xlsx")
boe<-read.xlsx2("./data/cpiinternet.xls", sheetName="CPI Forecast", startRow=5, stringsAsFactors=FALSE)
names(boe)[1:4]<-c("year0","month0","quarter0","statistic")
cn<-names(boe)[-(1:4)]

head(boe)
tail(boe)
#sort out first two periods (missing uncertianty and skewness for market forecast)
id<-c(6:8,4:5,1:5)
boe<-rbind(boe[c(id,id+8),],boe[-(1:16),])
#add year in all rows
boe$year0<-c(rep(2004:2013,each=10*4))
#add month in all rows
mn<-month.abb[seq(2, 11, 3)]
boe$month0<-rep(mn,each=10)
boe$month0<-factor(boe$month0, levels=mn)
boe$quarter0<-boe$month0
levels(boe$quarter0)<-paste0("Q",1:4)

# #add date as as.Date (replaceing IR indicator)
# boe$date0<-paste0(1,boe$month0,boe$year0)
# boe$date0<-strptime(boe$date0, "%d%b%Y")
# boe$date0<-format(boe$date0, "%b %Y")

tail(boe)
#add numeric time (replaceing IR indicator)
#keep only statistics for market assumption (mean, uncertainty and skew)
id<-c(1,4:5)+rep(seq(0,nrow(boe)-10,by=10),each=3)
boe<-boe[id,]
boe[,-(1:4)]<-data.matrix(boe[,-(1:4)])

#reshape
boe<-reshape(boe, direction="long", varying=list(5:ncol(boe)), v.name="y", times=cn)
#remove columns and NA
boe$id<-NULL
boe<-boe[!is.na(boe$y),]
#column for each statistic
boe<-reshape(boe, direction="wide",  timevar="statistic", idvar=c("year0", "month0", "quarter0", "time"))
#rename columns
names(boe)[5:7]<-c("mode","uncertainty", "skew")
library("plyr")
boe<-arrange(boe, year0, month0, time)

boe$year<-as.numeric(substring(boe$time,2,5))
boe$quarter<-substring(boe$time,6,7)
boe$quarter0<-as.character(boe$quarter0)
boe$month0<-NULL
boe$time0<-boe$year0+0.25*(as.numeric(gsub("Q","", boe$quarter0))-1)
boe$time <-boe$year +0.25*(as.numeric(gsub("Q","", boe$quarter ))-1)
boe<-boe[,c("time0","time","mode","uncertainty","skew")]

head(boe,20)
tail(boe,20)

subset(boe, time0==2013.75 )
#subset(boe, time0==2013 & quarter0=="Q1")

save(boe,file = "./data/boe.RData")




##
##th.mcmc
##
## write model file:
my1<-dget("./inst/model/my1.R")
write.model(my1, "my1.txt")

library("R2OpenBUGS")
library("tsbugs")
## take a look:
#file.show("my1.txt")
## run openbugs
my1.bugs<-bugs(data=list(n=length(svpdx$pdx),y=svpdx$pdx), 
               inits=list(list(phistar=0.975,mu=0,itau2=50)),
               param=c("mu","phi","tau","theta"), 
               model="my1.txt", bugs.seed=1,
               n.iter=1100, n.burnin=100, n.chains=1, n.thin=10)
th.mcmc <- round(my1.bugs$sims.list$theta,3)
save(th.mcmc, file="./data/thmcmc.RData")
ls()

file.remove("my1.txt")


##
##ips
##
ips<-read.csv("./data/ips.csv")
head(ips)
plot(ts(ips$net, 1975))
save(ips, file = "./data/ips.RData")


##
##Compress
##
tools::checkRdaFiles("./data")
tools::resaveRdaFiles("./data")


