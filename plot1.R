#Import Data
data <- read.csv("C:/Users/ars39/OneDrive - The Pennsylvania State University/Desktop/exdata_data_household_power_consumption/household_power_consumption.txt", sep=";")

#Subet the observations by date
library(dplyr) 
library(lubridate) #Works with Dates 

data2<-data %>%
  mutate(Date = dmy(Date)) %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

png("plot1.png", width=480, height=480)
hist(as.numeric(data2$Global_active_power),col="red",xlab="Global Active Power (kilowatts)",ylim=c(0,1200),main="Global Active Power")
dev.off()
