## Downloading the data
if(!file.exists("dataset.zip")) {
   fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   filename <- "dataset.zip"
   download.file(fileURL, filename)
}
   
if(!file.exists("household_power_consumption.txt")) {
        unzip(filename)  
}

## Loading the data
full_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
full_data$Date <- as.Date(full_data$Date, "%d/%m/%Y")

## Subsetting the data
data <- subset(full_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_data)

## Setting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Creating Plot 3
with(data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Energy Submetering", xlab="")
        lines(Sub_metering_2~Datetime,col="Red")
        lines(Sub_metering_3~Datetime,col="Blue")
})       
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Saving in png graphic file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()