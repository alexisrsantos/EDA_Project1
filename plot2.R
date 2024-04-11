#Import Data
data <- read.csv("C:/Users/ars39/OneDrive - The Pennsylvania State University/Desktop/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";")

#Subet the observations by date
library(dplyr) 
library(lubridate) #Works with Dates 

data2<-data %>%
  mutate(Date = dmy(Date)) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


data2$id<-rownames(data2)

data2$id2<-ifelse(data2$id==1,"Thu",
                  ifelse(data2$id==1441,"Fri",
                         ifelse(data2$id==2880,"Sat","")))


png("plot2.png", width=480, height=480)

plot(x=data2$id,y=as.numeric(data2$Global_active_power),xlab="",type="S",xaxt="n",
     ylim=c(0,7.5),ylab = "Global Active Power (kilowatts)")

axis(side = 1, at = c(as.numeric(data2$id[1]),
                      as.numeric(data2$id[1441]),
                      as.numeric(data2$id[2880])),labels = c("Thu","Fri","Sat"))
dev.off()
