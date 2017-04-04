//
//  PinyinTool.swift
//  Chino
//
//  Created by Yangyang on 2017/4/2.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class PinyinTool: NSObject {
    class func hanziToPinyin(hanzi: String!) -> String {
        let string = NSMutableString.init(string: hanzi) as CFMutableString
        if CFStringTransform(string, nil, kCFStringTransformMandarinLatin, false) == true{
            return string as String
        }else{
            return "Oops!"
        }
    }
    
    class func hanziToPinyinWithoutDiacritics(hanzi: String!) -> String {
        let string = self.hanziToPinyin(hanzi: hanzi)
        let str1 = NSMutableString.init(string: string) as CFMutableString
        if CFStringTransform(str1, nil, kCFStringTransformStripDiacritics, false) == true{
            return str1 as String
        }else{
            return "Oops!"
        }
    }
}
