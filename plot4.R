# Open Graphics Device - png
png(file = "plot4.png");
# Since we will extracting only a subset, it will not have the headers
# So create a vector with the headers. This will be used in the read.table command
columnnames <- c("Date", "Time", "Global_Active_Power","Global_Reactive_Power","Voltage", "Intensity", "Sub_Metering_1","Sub_Metering_2","Sub_Metering_3");
# Read the subset of data specified. two days of data
inputdata <- read.table("household_power_consumption.txt",header=FALSE,sep=";",quote="",col.names  = columnnames, skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2*60*24);
#Create a new column that will have the concatenated Date and Time
# Convert that column into the correct format using strptime
# Use the time zone correctly for your time zone
inputdata$NewDate <- strptime(paste(inputdata$Date, inputdata$Time, " "),"%d/%m/%Y %H:%M:%S", tz = "America/Chicago");
# Now we need to plot 4 graphs in 2 rows, 2 per row
# Firt we set up the locations for the graphs
par(mfrow = c(2,2));
# The first graph - row 1, column 1
plot(inputdata$NewDate,inputdata$Global_Active_Power,type = "l",xlab = "",ylab = "Global Active Power(kilowatts)",  yaxp = c(0,8,4));
# The second graph - row 1, column 2
plot(inputdata$NewDate, inputdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", yaxp = c(232,248,8));
# The 3rd graph - row 2, column 1
# Plot the graph. Note that the type is set to l
# Note that the ylim is set as the range across the inputs
plot(inputdata$NewDate,inputdata$Sub_Metering_1,ylim = range(c(inputdata$Sub_Metering_1, inputdata$Sub_Metering_2)),type = "l",xlab = "",ylab = "Energy Sub Metering",  yaxp = c(0,40,4));
# Set up for a new graph in the same plot 
par(new=TRUE);
# Draw the second graph
plot(inputdata$NewDate,inputdata$Sub_Metering_2,ylim = range(c(inputdata$Sub_Metering_1, inputdata$Sub_Metering_2)),type = "l",axes = FALSE, col = "red",xlab = "",ylab = "");
# Set up for a new graph in the same plot
par(new = TRUE);
# Draw the third graph
plot(inputdata$NewDate,inputdata$Sub_Metering_3,ylim = range(c(inputdata$Sub_Metering_1, inputdata$Sub_Metering_2)),type = "l",axes = FALSE, col = "blue",xlab = "",ylab = "");
# Set up the legend text
legend.txt <- c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3")
# Create the legend. Note the line specification lty, lwd, and color
legend("topright", legend = legend.txt, lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"))
# The 4th and last graph - row 2, column 2
plot(inputdata$NewDate, inputdata$Global_Reactive_Power, type = "l", xlab = "datetime", ylab = "Global_Reactive_Power");
# turn the graphics device off
dev.off()