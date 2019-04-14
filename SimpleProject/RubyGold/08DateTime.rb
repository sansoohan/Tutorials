require "date"

date1 = Date.new(2019,4,2)
date2 = Date.new(2019,4,3)
p date1
p date1 + 1
p date1 >> 1
p (date1-date1).class
p (date2-date1)

dateTime1 = DateTime.new(2019,4,2,15,20,30)
dateTime2 = DateTime.new(2019,4,2,15,20,31)
p dateTime1
p dateTime1 + 1
p dateTime1 >> 1
p (dateTime1-dateTime1).class
p (dateTime2-dateTime1)

time1 = Time.new(2019,4,2,15,20,30)
time2 = Time.new(2019,4,2,15,20,31)
p time1
p time1 + 1
p (time1-time1).class
p (time2-time1)