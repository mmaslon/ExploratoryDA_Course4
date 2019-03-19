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
#plot6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?
SCCmotor2<-NEI[grep("ON-ROAD",NEI$type),]
EmissionsVehicle<-subset(SCCmotor2,fips=="06037"|fips=="24510")
EmissionsByYearVehicle<-aggregate(EmissionsVehicle["Emissions"],by=EmissionsVehicle["year"],sum)
q6<-EmissionsVehicle%>%group_by(fips,year)%>%summarise(emissions_per_type=sum(Emissions))%>%ungroup()
ggplot(data=q6, aes(x=year, y=emissions_per_type, fill=fips)) + geom_bar(stat="identity", position=position_dodge())+labs(title="Emissions from motor vehicle in Baltimore City(24510) and Los Angeles County(06037)")+theme(plot.title=element_text(size=8))

