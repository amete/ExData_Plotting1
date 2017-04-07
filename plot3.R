# Download the data
data.file.name <- "household_power_consumption.txt"
if(!file.exists(data.file.name)) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "data.zip",
                  method = "curl")
    unzip("data.zip")
    file.remove("data.zip")
}

# Read the data
if(!require(data.table)) {
    install.packages("data.table")
    require(data.table)
}
if(!require(dplyr)) {
    install.packages("dplyr")
    require(dplyr)
}
input.data <- tbl_df(fread(data.file.name,na.strings=c('?', '', 'NA')))

# Select the data
selected.data <- input.data[input.data$Date == "1/2/2007" | input.data$Date == "2/2/2007",]

# Pick the complete cases
selected.data <- selected.data[complete.cases(selected.data),]

# Add data_time
selected.data$date_time <- strptime(paste(selected.data$Date,selected.data$Time), format = "%d/%m/%Y %H:%M:%S")

# Plot
png("plot3.png", width=480, height=480, units = "px", type="quartz")
with(selected.data,plot(date_time,
                        Sub_metering_1,
                        type = "n",
                        xlab = "",
                        ylab = "Energy sub metering"))
lines(selected.data$date_time,
       selected.data$Sub_metering_1,
       col = "black")
lines(selected.data$date_time,
       selected.data$Sub_metering_2,
       col = "red")
lines(selected.data$date_time,
       selected.data$Sub_metering_3,
       col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       lwd = c(1,1,1),
       col = c("black","red","blue"))

# Save and quit
dev.off()
