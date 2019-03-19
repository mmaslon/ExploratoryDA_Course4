#set path
#create variable which contains path to working directory
library(dplyr)
library(data.table)
library(ggplot2)
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
#plot2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
EmissionsBaltimore<-subset(NEI,fips=="24510")
EmissionsByYearBaltimore<-aggregate(EmissionsBaltimore["Emissions"],by=EmissionsBaltimore["year"],sum)
with(EmissionsByYearBaltimore,barplot(Emissions,main="Emissions per year",xlab="Year",ylab="pm25",col="darkred",names.arg = c("1999","2002","2005","2008")))
