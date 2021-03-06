library(tidyverse)
library(lubridate)

#Download data
if(!dir.exists('data')) {
    dir.create('data')
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = 'data')
    unlink(temp)
}

data <- read_delim(
    file.path('data','household_power_consumption.txt'),
    ';',
    na = '?')
plotData <- data %>%
    mutate(Date = dmy(Date), Time = hms(Time)) %>%
    filter(Date %in% ymd(c(' 2007-02-01', ' 2007-02-02')))

png('plot4.png')
par(mfrow=c(2,2), mar = c(4, 4, 1, 2))

with(plotData, plot((Date + Time), Global_active_power,
                    type = 'n',
                    ylab = 'Global Active Power',
                    xlab = ''))
with(plotData, lines((Date + Time), Global_active_power,
                     type = 'l', col = 'orange'))

with(plotData, plot((Date + Time), Voltage,
                    type = 'n',
                    ylab = 'Voltage',
                    xlab = 'Time'))
with(plotData, lines((Date + Time), Voltage,
                     type = 'l', col = 'violet'))

with(plotData, plot((Date+Time), Sub_metering_1,
                    type = 'n',
                    ylab = 'Enegy sub metering',
                    xlab = ''))
with(plotData, lines((Date + Time), Sub_metering_1, type = 'l', col = 'red'))
with(plotData, lines((Date + Time), Sub_metering_2, type = 'l', col = 'green'))
with(plotData, lines((Date + Time), Sub_metering_3, type = 'l', col = 'blue'))
legend('topright',
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty = c(1, 1, 1),
       col = c('red', 'green', 'blue'))

with(plotData, plot((Date + Time), Global_reactive_power,
                    type = 'n',
                    ylab = 'Global reactive power',
                    xlab = 'Time'))
with(plotData, lines((Date + Time), Global_reactive_power,
                     type = 'l', col = 'brown'))

dev.off()
