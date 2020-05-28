# Title: Exploratory Analysis Week 1 Assignment - plot4.R
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

# draw 4 line plots 

par(mfrow = c(2,2))

# upper left plot
with(household_power_consumption, plot(datetime, Global_active_power, 
              ylab = "Global Active Power", xlab = "", type = "l"))

# upper right plot
with(household_power_consumption, plot(datetime, Voltage, 
                ylab = "Voltage", xlab = "datetime", type = "l",
                yaxt = "n"))

axis(2, at = seq(234, 246, by = 2), labels = c("234", "", "238", "","242","","246"))

# lower left plot
plot(household_power_consumption$datetime, household_power_consumption$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", type = "l")

lines(household_power_consumption$datetime, household_power_consumption$Sub_metering_2, col = "red")

lines(household_power_consumption$datetime, household_power_consumption$Sub_metering_3, type = "l", col = "blue")

legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.8, bty = "n", inset = .02)

# lower right plot
with(household_power_consumption, plot(datetime, Global_reactive_power, type = "l",
                            ylab = "Global_reactive_power", xlab = "datetime"))

# save to file
dev.copy(png, "plot4.png", height = 480, width = 480)
dev.off()

