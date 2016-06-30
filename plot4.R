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

## Creating Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy Submetering", xlab="")
        lines(Sub_metering_2~Datetime,col="Red")
        lines(Sub_metering_3~Datetime,col="Blue")
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power",xlab="datetime")
})

## Saving in png graphic file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()