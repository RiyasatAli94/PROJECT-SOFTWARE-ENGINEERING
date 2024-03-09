//
//  DateConverter.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import Foundation
class DateConverter{
    
    static func selectDate(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date1 = formatter.date(from: "\(date)")
        formatter.dateFormat = "E, d MMM yyyy"
        return formatter.string(from: date1!)
    }
    
    
    static func myDate(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date1 = formatter.date(from: "\(date)")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date1!)
    }
    
    
    static func myStartTime(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date1 = formatter.date(from: "\(date)")
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date1!)
    }
    
    
    static func myEndTime(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date1 = formatter.date(from: "\(date)")
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date1!)
    }
    
    
    static func RemiderDate(date : String) -> Date{
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        //dateFormatter.timeZone = NSTimeZone.local
        
        let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        //dateFormatter.timeZone = NSTimeZone.local
        print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        return dateObj!
    }
    
    static func serverToLocal(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        return localDate
    }
}
