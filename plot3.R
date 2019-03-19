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
#plot3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
EmissionsBaltimore<-subset(NEI,fips=="24510")
q3<-EmissionsBaltimore%>%group_by(type,year)%>%summarise(emissions_per_type=sum(Emissions))%>%ungroup()
#axis treated as discrete variable (rather than continous)
q3$year<-as.factor(q3$year)
ggplot(data=q3, aes(x=year, y=emissions_per_type, fill=type)) + geom_bar(stat="identity", position=position_dodge())
