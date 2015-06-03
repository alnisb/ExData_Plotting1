# plot2.R
# Alnis Bajars. 2015-06-02.
# Produce plot2.png as per visual spec in Course Project 1 of
# Exploratory Data Analysis at Johns Hopkins.

# Need to download source data from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzip into local folder.

plot2 <- function()  {

    # load up data, sqldf is an elegant solution to get only what we need
    # Source data unpacked in working folder on GitHub
    library(sqldf)
    measures <- read.csv.sql("household_power_consumption.txt", 
                             sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                             sep = ";", header = TRUE)  
    closeAllConnections()
    
    # Need a proper date/time to work off
    measures$Date <- as.Date(measures$Date, "%d/%m/%Y")
    measures$DateTime <- strptime(paste(as.character(measures$Date),measures$Time), "%Y-%m-%d %H:%M:%S")
    
    # Create PNG file directly to device
    png("plot2.png", width=480, height=480)
    
    # Plot continuous line
    plot(measures$DateTime, measures$Global_active_power, 
         type = "l",
         ylab= "Global Active Power (kilowatts)",
         xlab = "")
    
    # effectively saves the PNG file
    dev.off()
}