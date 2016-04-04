
## Plots the 4th plot from Exploratory Data Analysis - Week 1 using data from:
## https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

## **Requires dplyr package**

download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip","~/R/household_power_consumption.zip")
unzip("~/R/household_power_consumption.zip",exdir="~/R")

## dtypes = Character matrix of the 9 data types of the data to be read
dtypes<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric",
          "numeric")

## Data read from local copy of UCI dataset
c_data<-read.table("~/R/household_power_consumption.txt",header=TRUE,sep=";",colClasses = dtypes,
                   na.strings = "?")

## Converts character Date variable to objects of type "Date" 
my_data<-mutate(c_data,Date=as.Date(Date,"%d/%m/%Y"))

## Preserves data from February 1-2 2007
my_data<-filter(my_data,Date>="2007-02-01" & Date<="2007-02-02")

## Converts character Time variable to an object of type "POSIXlt" "POSIXt"
my_data$Time<-strptime(paste(my_data$Date,my_data$Time),"%Y-%m-%d %H:%M:%S")


par(mfrow=c(2,2))
plot(my_data$Time,my_data$Global_active_power,type="l",ylab = "Global Active Power", 
     xlab="")
plot(my_data$Time,my_data$Voltage,type="l",ylab = "Voltage",xlab="datetime")
plot(time,my_data$Sub_metering_1,type="l",ylim=c(0,40),ylab = '',xlab = '',yaxt="n")
par(new=T)
plot(time,my_data$Sub_metering_2,type="l",ylim=c(0,40),col="red",xlab = '',ylab = '',yaxt="n")
par(new=T)
plot(time,my_data$Sub_metering_3,type="l",ylim=c(0,40),col="blue",ylab = "Energy sub metering",
     xlab = '',yaxt="n")
axis(side=2,at=c(0,10,20,30))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,
       col=c("black","red","blue"),bty = "n",cex=0.65)
plot(my_data$Time,my_data$Global_reactive_power,type="l",ylab = "Global_reactive_power",
     xlab="datetime")
dev.print(png, file = "~/R/Plot4.png", width = 480, height = 480)
par(mfrow=c(1,1))
