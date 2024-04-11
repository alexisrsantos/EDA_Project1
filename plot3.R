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

png("plot3.png", width=480, height=480)
data2$Sub_metering_1<-as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2<-as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3<-as.numeric(data2$Sub_metering_3)

plot(data2$id,data2$Sub_metering_1,xlab="",xaxt="n",type = "S",col="black",
     ylab="Energy sub meeting")
lines(data2$id, data2$Sub_metering_2, type="l", col="red")
lines(data2$id, data2$Sub_metering_3, type="l", col="blue")
axis(side = 1, at = c(as.numeric(data2$id[1]),
                      as.numeric(data2$id[1441]),
                      as.numeric(data2$id[2880])),labels = c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
dev.off()
