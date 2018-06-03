# Loading the data
Household <- read.table("household_power_consumption.txt", skip = 1, sep = ";", na.strings = "?")
head(Household)

# Adding variable names
cnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
            "Sub_metering_3")
colnames(Household) <- cnames

# Formatting dates
Household$Date <- as.Date(Household$Date, "%d/%m/%Y")

# Subsetting for 2007-02-01 and 2007-02-02
Household2 <- subset(Household, Household$Date == "2007-02-01" | Household$Date == "2007-02-02")
rm("Household")

# Creating the histogram and saving it to a png file
hist(Household2$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "red")
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()
