//
//  HanziModel.swift
//  Chino
//
//  Created by Yangyang on 2017/3/30.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class HanziModel: NSObject {
    
    public var HZID:String!
    public var hanzi:String!
    public var pinyin:String?

    init(id: String, character:String, Pinyin:String) {
        super.init()
        HZID = id;
        hanzi = character;
        pinyin = Pinyin;
    }
}
