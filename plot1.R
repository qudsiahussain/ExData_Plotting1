## Downloading the data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "dataset.zip"
download.file(fileURL, filename)
unzip(filename)

## Loading the data
full_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
full_data$Date <- as.Date(full_data$Date, format = "%d/%m/%Y")

## Subsetting the data
data <- subset(full_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_data)

## Setting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Creating Plot 1
hist(data$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving in png graphic file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()