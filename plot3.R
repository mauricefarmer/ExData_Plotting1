# Title: Exploratory Analysis Week 1 Assignment - plot3.R
# author: MKF
# 28/05/2020

library(readr)
library(lubridate)

# check if data file exists in directory. If not, download and unzip
if (!file.exists("household_power_consumption.txt")) {
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "zipped.zip", method = "curl")
  
  unzip("zipped.zip")
}

# read only lines for 1/2/2007 & 2/2/2007 & add column titles
household_power_consumption <- read.delim("household_power_consumption.txt", header = TRUE,
                                          sep = ";", na = "?", skip=66636, nrows = 2880)

names(household_power_consumption) <- unlist(strsplit(header_Names, ";"))

# create a single datetime column in POSIXct format
household_power_consumption$datetime = paste(household_power_consumption$Date, household_power_consumption$Time)

household_power_consumption$datetime <- dmy_hms(household_power_consumption$datetime)

# draw line plot of Sub Metering versus Time
plot(household_power_consumption$datetime, household_power_consumption$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", type = "l")

lines(household_power_consumption$datetime, household_power_consumption$Sub_metering_2, col = "red")
     
lines(household_power_consumption$datetime, household_power_consumption$Sub_metering_3, type = "l", col = "blue")
     
legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# save to file
dev.copy(png, "plot3.png", height = 480, width = 480)
dev.off()

