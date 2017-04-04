//
//  ChinoModel.swift
//  Chino
//
//  Created by Yangyang on 2017/3/30.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class ChinoModel: NSObject {
    public var title:String!
    public var detail:String!
    public var date:String!
    public var likes:NSNumber?
    public var comments:NSNumber?
    
    init(titleStr:String, detailStr:String, dateStr:String, likesNum:NSNumber, commentsNum:NSNumber) {
        super.init()
        self.title = titleStr;
        self.detail = detailStr;
        self.date = dateStr;
        self.likes = likesNum;
        self.comments = commentsNum;
    }
    
}
