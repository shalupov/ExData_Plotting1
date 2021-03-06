Sys.setlocale("LC_ALL", "English")

# Download dataset
data_source <- "household_power_consumption.txt"
if (!file.exists(data_source)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# Load data
raw <- read.table("household_power_consumption.txt", sep=";", na.strings="?", comment.char="", header=TRUE,
                  colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Filter it by date
data <- raw[raw$Date == "1/2/2007" | raw$Date == "2/2/2007",]

# Convert date and time columns to real datetime
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Plot
png("plot3.png")
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type="l", xlab="", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", xlab="", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), lty = 1)
dev.off()
