# plot1.R
# Alnis Bajars. 2015-06-02.
# Produce plot1.png as per visual spec in Course Project 1 of
# Exploratory Data Analysis at Johns Hopkins.

# Need to download source data from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzip into local folder.

plot1 <- function()  {

    # load up data, sqldf is an elegant solution to get only what we need
    # Source data unpacked in working folder on GitHub
    library(sqldf)
    measures <- read.csv.sql("household_power_consumption.txt", 
                             sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                             sep = ";", header = TRUE)  
    closeAllConnections()
    
    # Create PNG file directly to device
    png("plot1.png", width=480, height=480)
    
    # make the histogram, red fill, specced labels
    hist(measures$Global_active_power,
         xlab= "Global Active Power (kilowatts)",
         main = "Global Active Power",
         col = "Red")
    
    # effectively saves the PNG file
    dev.off()
}