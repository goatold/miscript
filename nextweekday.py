#!/bin/env python

import datetime
import calendar

def nextWeekday(d, wd):
    delta = wd - d.weekday()
    if (delta >= 0):
        return d + datetime.timedelta(delta)
    else:
        return d + datetime.timedelta(7+delta)

def lastWeekday(d, wd):
    delta = d.weekday() - wd
    if (delta >= 0):
        return d - datetime.timedelta(delta)
    else:
        return d - datetime.timedelta(7+delta)


print(nextWeekday(datetime.date(2018,5,1), calendar.THURSDAY))
print(nextWeekday(datetime.date(2018,5,1), calendar.WEDNESDAY))
print(nextWeekday(datetime.date(2018,11,1), calendar.MONDAY))

print(lastWeekday(datetime.date(2018,10,31), calendar.THURSDAY))
print(lastWeekday(datetime.date(2018,10,31), calendar.SUNDAY))
print(lastWeekday(datetime.date(2018,10,31), calendar.WEDNESDAY))
