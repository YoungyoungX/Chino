//
//  ChinoHanziModel.swift
//  Chino
//
//  Created by Yangyang on 2017/4/2.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import LeanCloud

class ChinoHanziModel: LCObject {
    dynamic var name: LCString?
    
    dynamic var hanzi: LCString!
    dynamic var hanziPY: LCString!
    dynamic var hanziEng: LCString!
    dynamic var words: LCString!
    dynamic var wordsPY: LCString!
    dynamic var wordsEng: LCString!
    dynamic var sentence: LCString!
    dynamic var sentencePY: LCString!
    dynamic var sentenceEng: LCString!
    
    override static func objectClassName() -> String {
        return "ChinoHanziModel"
    }
    
}
