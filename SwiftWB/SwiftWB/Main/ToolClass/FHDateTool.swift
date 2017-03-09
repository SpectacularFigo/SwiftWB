//
//  FHDateTool.swift
//  DateTimeTool
//
//  Created by Figo Han on 2017-02-20.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit

class FHDateTool: NSObject {
    
    class func fh_date(dateTimeString: String) -> String
    {
        
        // 格式化之后一定都会转化成0时区
//            let dateTimeString = "Tue Jan 31 10:22:29 +0800 2017"
        
        
        
        
        //NSDateformatter--->Use custom formatter to convert string to NSdate
        //1. Set DateFormate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        
        //2. Use date Formatter to transfer String to NSDate
        let time = dateFormatter.date(from: dateTimeString) // it is Date?
        guard let createTime = time else {
            return "Time is Wrong"
        }
        
        
        
        //3. 计算间隔时间
        let nowDate = Date()
        
        let timeIntervalFromNow = nowDate.timeIntervalSince(createTime) //时间差应该是Double类型 aka Double
        
        
        // Tweet in one minute
        if timeIntervalFromNow < 60{
            return "Just Now"
        }
        
        // Tweet in one hour
        if timeIntervalFromNow < 60 * 60 {
            return "This is \(timeIntervalFromNow/60/60) hours ago"
        }
        
        //这下面用到了NSCalander   Tweet in yesterday
        let calander = NSCalendar.current
        if  calander.isDateInYesterday(createTime) {
            dateFormatter.dateFormat="MM:dd HH:mm"
            return dateFormatter.string(from: createTime)
        }
        
        
        return "Tweeted long Time ago"
        
    }

}
