# Open Graphics Device - png
png(file = "plot2.png");
# Since we will extracting only a subset, it will not have the headers
# So create a vector with the headers. This will be used in the read.table command
columnnames <- c("Date", "Time", "Global_Active_Power","Global_Reactive_Power","Voltage", "Intensity", "Sub_Metering_1","Sub_Metering_2","Sub_Metering_3");
# Read the subset of data specified. two days of data
inputdata <- read.table("household_power_consumption.txt",header=FALSE,sep=";",quote="",col.names  = columnnames, skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2*60*24);
#Create a new column that will have the concatenated Date and Time
# Convert that column into the correct format using strptime
# Use the time zone correctly for your time zone
inputdata$NewDate <- strptime(paste(inputdata$Date, inputdata$Time, " "),"%d/%m/%Y %H:%M:%S", tz = "America/Chicago");
# Plot the graph. Note that the type is set to l
plot(inputdata$NewDate,inputdata$Global_Active_Power,type = "l",xlab = "",ylab = "Global Active Power(kilowatts)",  yaxp = c(0,8,4));
# turn the graphics device off
dev.off()