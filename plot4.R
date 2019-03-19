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
#plot4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#in SCC look for word coal and save as new variable
SCCcoal<-SCC[grep("[Cc]oal",SCC$Short.Name),]
#get only entries from NEI with SCC code for coal
EmissionsCoalByYear<-subset(NEI,SCC%in%SCCcoal$SCC)
EmissionsByYearcoal<-aggregate(EmissionsCoalByYear["Emissions"],by=EmissionsCoalByYear["year"],sum)
with(EmissionsByYearcoal,barplot(Emissions,main="Emissions per year",xlab="Year",ylab="pm25",col="darkred",names.arg = c("1999","2002","2005","2008")))
