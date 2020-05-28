# Title: Exploratory Analysis Week 1 Assignment - plot1.R
# author: MKF
# 28/05/2020

library(readr)

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

# draw histogram of Global Active Power 
hist(household_power_consumption$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

# save to file
dev.copy(png, "plot1.png", height = 480, width = 480)
dev.off()

