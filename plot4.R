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

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(x=data2$id,y=as.numeric(data2$Global_active_power),xlab="",type="S",xaxt="n",
     ylim=c(0,7.5),ylab = "Global Active Power (kilowatts)")

axis(side = 1, at = c(as.numeric(data2$id[1]),
                      as.numeric(data2$id[1441]),
                      as.numeric(data2$id[2880])),labels = c("Thu","Fri","Sat"))

# Figure 2
plot(x=data2$id,y=as.numeric(data2$Voltage),type="S",xaxt="n",ylim=c(234,246),ylab = "Voltage",xlab="datetime")

axis(side = 1, at = c(as.numeric(data2$id[1]),
                      as.numeric(data2$id[1441]),
                      as.numeric(data2$id[2880])),labels = c("Thu","Fri","Sat"))

#Figure 3
##Recoded
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

# Figure 4
data2$Global_reactive_power<-as.numeric(data2$Global_reactive_power)

plot(x=data2$id,y=data2$Global_reactive_power,type="S",xaxt="n",ylim=c(0,0.5),xlab="datetime",ylab="Global_reactive_power")

axis(side = 1, at = c(as.numeric(data2$id[1]),
                      as.numeric(data2$id[1441]),
                      as.numeric(data2$id[2880])),labels = c("Thu","Fri","Sat"))

dev.off()
