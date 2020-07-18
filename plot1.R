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
    mutate(Date = dmy(Date)) %>%
    filter(Date %in% ymd(c(' 2007-02-01', ' 2007-02-02')))

png('plot1.png')
with(plotData, hist(Global_active_power,
                    main = 'Global Active Power',
                    xlab = 'Global Active Power (kilowatts)'))
dev.off()
