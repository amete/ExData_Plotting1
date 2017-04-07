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

# Plot
png("plot1.png", width=480, height=480, units = "px", type="quartz")
hist(selected.data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red")

# Save and quit
dev.off()