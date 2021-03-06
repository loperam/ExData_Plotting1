library(data.table)
library(dplyr)

mydata<-fread("household_power_consumption.txt",sep=";", na.strings = c("NA","N/A","?"),stringsAsFactors=FALSE)
mydata$Date<-as.Date(mydata$Date, format = "%d/%m/%Y")
n1<-filter(mydata, mydata$Date == "2007-02-01" | mydata$Date=="2007-02-02")

n4<-paste(n1$Date, n1$Time)
n6<-strptime(n4, format = "%Y-%m-%d %H:%M:%S")
n6<-as.POSIXct(n6)
n1$DateTime<-n6

png(filename="plot4.png", width=480, height=480, units='px')

par(mfrow=c(2,2))

plot(n1$DateTime, n1$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(n1$DateTime, n1$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(n1$DateTime, n1$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
points(n1$DateTime, n1$Sub_metering_2,col = "red", type="l")
points(n1$DateTime, n1$Sub_metering_3,col = "blue",type="l")
legend("topright", lty=1, col = c("black","red","blue"),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(n1$DateTime, n1$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()