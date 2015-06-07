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
png("plot2.png")
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

