# Alnis Bajars. 2015-06-02.
# Produce plot4.png as per visual spec in Course Project 1 of
# Exploratory Data Analysis at Johns Hopkins.

# Need to download source data from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzip into local folder.

plot4 <- function()  {
    
    # load up data, sqldf is an elegant solution to get only what we need
    # Source data unpacked in working folder on GitHub
    library(sqldf)
    measures <- read.csv.sql("household_power_consumption.txt", 
                             sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                             sep = ";", header = TRUE)  
    closeAllConnections()
    
    # Need a proper date/time to work off
    measures$Date <- as.Date(measures$Date, "%d/%m/%Y")
    measures$DateTime <- strptime(paste(as.character(measures$Date),measures$Time), 
                                  "%Y-%m-%d %H:%M:%S")
    
    # Create PNG file directly to device
    png("plot4.png", width=480, height=480)
    
    # 4 discrete graphs/plots
    par(mfrow = c(2, 2))
    with(measures, {
        plot(DateTime, Global_active_power, type = "l",
             ylab= "Global Active Power", xlab = "")
        plot(DateTime, Voltage, type = "l",
             ylab= "Voltage", xlab = "datetime")
        plot(DateTime, Sub_metering_1, type = "l",
            ylab= "Energy sub metering", xlab = "", col = "black")
        with(measures, points(DateTime, Sub_metering_2, col = "red", type = "l"))
        with(measures, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
        legend("topright", lty = c(1,1), col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               bty = "n")
        plot(DateTime, Global_reactive_power, type = "l",
             ylab= "Global_reactive_power", xlab = "datetime")
    })
    
    # effectively saves the PNG file
    dev.off()
}