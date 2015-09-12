# Open Graphics Device - png
png(file = "plot1.png");
# Since we will extracting only a subset, it will not have the headers
# So create a vector with the headers. This will be used in the read.table command
columnnames <- c("Date", "Time", "Global_Active_Power","Global_Reactive, Power","Voltage", "Intensity", "Sub_Metering_1","Sub_Metering_2","Sub_Metering_3");
# Read the subset of data specified. two days of data
inputdata <- read.table("household_power_consumption.txt",header=FALSE,sep=";",quote="",col.names  = columnnames, skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2*60*24);
# Plot the histogram
hist(inputdata$Global_Active_Power, main = "Global Active Power",col = 554, xlab = "Global Active Power(kilowatts)", ylab  = "Frequency", yaxp = c(0,1200,6))
# turn the graphics device off
dev.off()