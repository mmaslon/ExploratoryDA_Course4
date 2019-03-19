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
#plot5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
SCCmotor2<-NEI[grep("ON-ROAD",NEI$type),]
EmissionsBaltimoreVehicle<-subset(SCCmotor2,fips=="24510")
EmissionsByYearBaltimoreVehicle<-aggregate(EmissionsBaltimoreVehicle["Emissions"],by=EmissionsBaltimoreVehicle["year"],sum)
with(EmissionsByYearBaltimoreVehicle,barplot(Emissions,main="Emissions per year",xlab="Year",ylab="pm25",col="darkred",names.arg = c("1999","2002","2005","2008")))
