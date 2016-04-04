## Plots the 2nd plot from Exploratory Data Analysis - Week 1 using data from:
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

## Plots
plot(my_data$Time,my_data$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)", 
     xlab="")
dev.print(png, file = "~/R/Plot2.png", width = 480, height = 480)
