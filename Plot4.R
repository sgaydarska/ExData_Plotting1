# Loading the data
Household <- read.table("household_power_consumption.txt", skip = 1, sep = ";", na.strings = "?")
head(Household)

# Adding variable names
cnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
            "Sub_metering_3")
colnames(Household) <- cnames

# Formatting dates and times
Household$Date <- as.Date(Household$Date, "%d/%m/%Y")

# Subsetting for 2007-02-01 and 2007-02-02
Household2 <- subset(Household, Household$Date == "2007-02-01" | Household$Date == "2007-02-02")
rm("Household")

# Creating a combined date/time variable
Household2$datetime <- paste(Household2$Date, Household2$Time)
Household2$datetime <- as.POSIXct(Household2$datetime)

# Creating and saving the plot to a png file
par(mfrow = c(2,2), mar = c(4.2, 4.1, 3, 2.1))
plot(Household2$Global_active_power~Household2$datetime, type = "l", xlab = "", ylab = "Global Active Power")
plot(Household2$datetime, Household2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(Household2$Sub_metering_1~Household2$datetime, type = "l", xlab = "", ylab = "Energy sub metering")
lines(Household2$Sub_metering_2~Household2$datetime, col = "red")
lines(Household2$Sub_metering_3~Household2$datetime, col = "blue")
legend("topright", lty = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
plot(Household2$datetime, Household2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", height=480, width=480)
dev.off()
