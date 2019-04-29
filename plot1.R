#Read the downloaded data set for household power consumption into variable Z_read_data
Z_read_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
##Format the Date column to class Date
Z_read_data$Date <- as.Date(Z_read_data$Date, "%d/%m/%Y")
## SUbset the data to select only the dates 01/02 and 02/02 from the year 2007
Z_read_data <- subset(Z_read_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
###> class(Z_read_data$Date)
## dim(Z_read_data)
##[1] 2880    9
##Remove incomplete observations
Z_read_data <- Z_read_data[complete.cases(Z_read_data$Date), ]
#Create a new variable Timestamp that combines the date and time column
Timestamp <- paste(Z_read_data$Date,Z_read_data$Time)
#Name the column as Date/TimeStamp
Timestamp<- setNames(Timestamp, "Date/TimeStamp")
#Remove the existing column date and time
Z_read_data <- Z_read_data[ ,!(names(Z_read_data) %in% c("Date","Time"))]
#Add the new column Date/Timestamp
Z_read_data <- cbind(Timestamp,Z_read_data)
#Format the timestamp column
Z_read_data$Timestamp <- strptime(Z_read_data$Timestamp,format = "%Y-%m-%d %H:%M:%S")
##class(Z_read_data$Timestamp)
## "POSIXlt" "POSIXt" 

##Create Histogram
par(mfrow= c(1,1))
hist(Z_read_data$Global_active_power , main = "Global Active Power" , xlab = "Global Active Power (Kilowatts)" , 
     col = "red")
dev.copy(png,"plot1.png", width =1024 , height = 780)
#png 
#4 
dev.off()