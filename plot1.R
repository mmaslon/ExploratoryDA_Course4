#set path
#create variable which contains path to working directory
library(dplyr)
library(data.table)
path<-getwd()

#create variable specifying URL where the data is stored\
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename<-"dataset.zip"
if(!file.exists(path)) { dir.create(path) }
download.file(fileUrl,destfile = filename, method="curl")
zipF<-file.choose()
unzip(zipF,exdir=path)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#sum of emission for each year
EmissionsByYear<-aggregate(NEI["Emissions"],by=NEI["year"],sum)
#create plot
with(EmissionsByYear,barplot(Emissions,main="Emissions per year",xlab="Year",ylab="pm25",col="darkred",names.arg = c("1999","2002","2005","2008")))