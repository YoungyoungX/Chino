//
//  Reporter.swift
//  Chino
//
//  Created by Shiyangyang on 2017/3/26.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class Reporter: NSObject {

    class func LogEventWithName(event:String, paremeters:[String : NSObject]?) {
        FIRAnalytics.logEvent(withName: event, parameters: paremeters)
        
    }
}
