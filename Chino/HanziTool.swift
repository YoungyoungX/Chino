//
//  HanziTool.swift
//  Chino
//
//  Created by Yangyang on 2017/4/4.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class HanziTool: NSObject {

    class func dateToHanzi(date: NSNumber) -> String {
        let year = date.intValue/10000//need further implementation
        let month = (date.intValue - year*10000)/100
        var monthStr = String.init()
        switch month {
        case 1:
            monthStr = "一"
            break
        case 2:
            monthStr = "二"
            break
        case 3:
            monthStr = "三"
            break
        case 4:
            monthStr = "四"
            break
        case 5:
            monthStr = "五"
            break
        case 6:
            monthStr = "六"
            break
        case 7:
            monthStr = "七"
            break
        case 8:
            monthStr = "八"
            break
        case 9:
            monthStr = "九"
            break
        case 10:
            monthStr = "十"
            break
        case 11:
            monthStr = "十一"
            break
        case 12:
            monthStr = "十二"
            break
        default:
            monthStr = "某"
            break
        }
        monthStr = monthStr + "月"
        
        let day = date.intValue%100
        let dayStr = self.numberToHanzi(number: NSNumber.init(value: day)) + "日"
        
        return "二〇一七年" + monthStr + dayStr
    }
    
    private class func numberToHanzi(number: NSNumber) -> String {
        let ten = number.intValue/10
        let ge = number.intValue - ten * 10
        
        if ten == 0 {
            return self.singleNumberToHanzi(number:NSNumber.init(value: ge))
        }else{
            if ten == 1 {
                if ge == 0 {
                    return "十"
                }
                return "十" + self.singleNumberToHanzi(number:NSNumber.init(value: ge))
            }else{
                if ge == 0 {
                    return self.singleNumberToHanzi(number:NSNumber.init(value: ten)) + "十"
                }
                return self.singleNumberToHanzi(number:NSNumber.init(value: ten)) + "十" + self.singleNumberToHanzi(number:NSNumber.init(value: ge))
             }
        }
    }
    
    private class func singleNumberToHanzi(number: NSNumber) -> String {
        let num = number.intValue
        switch num {
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        case 7:
            return "七"
        case 8:
            return "八"
        case 9:
            return "九"
        case 10:
            return "十"
        case 0:
            return "〇"
        default:
            return ":)"
        }
    }
    
}
