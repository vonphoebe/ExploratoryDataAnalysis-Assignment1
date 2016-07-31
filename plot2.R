##  plot2.R

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


##  Extract observations for plotting specified line graph

plot2_data <- subset(household_power_consumption, 
                     household_power_consumption$Date <= "2007-02-02" & household_power_consumption$Date >= "2007-02-01")


##  Combine Date and Time variables to define a new Date-Time class variable
plot2_data$Date_Time <- as.POSIXct(paste(plot2_data$Date, plot2_data$Time))


##  Plot to screen device for visual inspection
plot(plot2_data$Global_active_power ~ plot2_data$Date_Time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

##  Plot and save to PNG file (480 x 480 pixels)
png(file = "plot2.png", width=480, height=480, units="px")
plot(plot2_data$Global_active_power ~ plot2_data$Date_Time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
