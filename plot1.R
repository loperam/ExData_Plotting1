library(data.table)
library(dplyr)

mydata<-fread("household_power_consumption.txt",sep=";", na.strings = c("NA","N/A","?"),stringsAsFactors=FALSE)
mydata$Date<-as.Date(mydata$Date, format = "%d/%m/%Y")
n1<-filter(mydata, mydata$Date == "2007-02-01" | mydata$Date=="2007-02-02")

n4<-paste(n1$Date, n1$Time)
n6<-strptime(n4, format = "%Y-%m-%d %H:%M:%S")
n6<-as.POSIXct(n6)
n1$DateTime<-n6

png(filename="plot1.png", width=480, height=480, units='px')
hist(n1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()