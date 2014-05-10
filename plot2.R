

################ Reading a subset of data.....This one works for Unix environments.
#hpc = read.csv(pipe('egrep \'^Date|^[1-2]/2/2007\' household_power_consumption.txt'), header=T, sep=';')


################ Reading a subset of data.....This one works with all environments, but is not as clean.
#f <- file("household_power_consumption.txt","rt");

#nolines <- 100
#greped<-c()
#repeat {
#  lines=readLines(f,n=nolines)       #read lines
#  idx <- grep("^[12]/2/2007", lines) #find those that match
#  greped<-c(greped, lines[idx])      #add the found lines
#  #
#  if(nolines!=length(lines)) {
#    break #are we at the end of the file?
#  }
#}
#close(f)

#tc<-textConnection(greped,"rt") #now we create a text connection and load data
#df<-read.csv(tc,sep=";",header=TRUE)


#install.packages("sqldf")
#setwd("C:\\Users\\Mother\\rprog\\Exp\\Assg1")

################################################################################################
################ Reading a subset of data.....This one uses SqL, nice but requires extra libraries.
################################################################################################
require ("sqldf")
myFile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"  #Reading only the 2 days of interest
myData <- read.csv.sql(myFile,mySql, header=TRUE, sep = ";")

## Generate date-time char data into POSIX for better date managment.
completo <- paste(myData$Date, myData$Time)
myDateTime <- strptime(completo,"%d/%m/%Y %H:%M:%S")


#Now creating the plot to a File Device
png(file = "plot2.png")     #open file device.
plot(myDateTime, myData$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()
