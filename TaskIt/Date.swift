//
//  Date.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 29/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import Foundation

class Date {

    class func from(#year: Int, month: Int, day: Int) -> NSDate {

        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day

        var gregorianCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components);

        return date!
    }

    class func toString(date: NSDate) -> String {
        return self.toStringWithFormat(date)
    }

    class func toStringWithFormat(date: NSDate, format:String = "dd-MM-yyyy") -> String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }

    class func toStringUsingLocale(date: NSDate) -> String {
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }

}