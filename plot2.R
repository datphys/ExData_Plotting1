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

png('plot2.png')
with(plotData, plot((Date + Time),
                    Global_active_power,
                    type = 'n',
                    ylab = 'Global Active Power (kilowatts)',
                    xlab = ''))

with(plotData, lines((Date + Time),
                     Global_active_power,
                     type = 'l',
                     col = 'red'))
dev.off()
