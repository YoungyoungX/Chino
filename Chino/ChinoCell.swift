//
//  ChinoCell.swift
//  Chino
//
//  Created by Yangyang on 2017/3/30.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class ChinoCell: UICollectionViewCell {
    
    @IBOutlet weak var colorLiner: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tvMain: UITextView!
    @IBOutlet weak var lbDate: UILabel!
    
    func congifWithChinoModel(model: ChinoHanziModel, color: UIColor) {
        self.colorLiner.backgroundColor = color
        self.lbTitle.text = model.hanzi.value + " " + model.hanziPY.value
        
        var body = model.hanziEng.value + "\n" + model.words.value;
        body = body + "\n" + model.wordsEng.value
        self.tvMain.text = body
        
        if model.chinoDate != nil{
            self.lbDate.text = model.chinoDate.value
        }else{
            self.lbDate.text = "某年某月某日"
        }
    }
}
