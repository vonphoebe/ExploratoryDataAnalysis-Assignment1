##  plot4.R

##  Load required packages


##  Download and un-Zip the source data

wd_path <- "~/Coursera - Data Science/4.Exploratory Data Analysis/Week1/Assignment"
setwd(wd_path)
url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(url, destfile = basename(url))
unzip(zipfile = basename(url), exdir = ".")


##  Load source data into data frame;  convert the Date variable to R Date class

household_power_consumption <- read.csv("household_power_consumption.txt", 
                                        header = TRUE, 
                                        sep = ";", 
                                        na.strings = "?", 
                                        stringsAsFactors = FALSE )

household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")


##  Extract relevant observations for plotting the four specified graphs of Plot #4

plot4_data <- subset(household_power_consumption, 
                     household_power_consumption$Date <= "2007-02-02" & household_power_consumption$Date >= "2007-02-01")

##  Combine Date and Time variables to define a new Date-Time class variable
plot4_data$Date_Time <- as.POSIXct(paste(plot4_data$Date, plot4_data$Time))

##  Set graphical parameters
par(mfrow = c(2,2), mar = c(4,4,3,2), oma = c(0,0,1,0))

##  Plot to screen device for visual inspection
with(plot4_data, {
     plot(Global_active_power   ~ Date_Time, type="l", ylab="Global Active Power",  xlab="")   
     plot(Voltage               ~ Date_Time, type="l", ylab="Voltage",              xlab="datetime")
     plot(Sub_metering_1        ~ Date_Time, type="l", ylab="Energy sub metering",  xlab="")
         lines(Sub_metering_2   ~ Date_Time, col="red")
         lines(Sub_metering_3   ~ Date_Time, col="blue")
         legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty = "n", 
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power ~ Date_Time, type="l", ylab="Global_rective_power", xlab="datetime") }
     )


##  Plot and save to PNG file device (480 x 480 pixels)
png(file = "plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2), mar = c(4,4,3,2), oma = c(0,0,1,0))
with(plot4_data, {
     plot(Global_active_power   ~ Date_Time, type="l", ylab="Global Active Power",  xlab="")
     plot(Voltage               ~ Date_Time, type="l", ylab="Voltage",              xlab="datetime")
     plot(Sub_metering_1        ~ Date_Time, type="l", ylab="Energy sub metering",  xlab="")
         lines(Sub_metering_2   ~ Date_Time, col="red")
         lines(Sub_metering_3   ~ Date_Time, col="blue")
         legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty = "n", 
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power ~ Date_Time, type="l", ylab="Global_rective_power", xlab="datetime") }
     )
dev.off()