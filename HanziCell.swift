//
//  HanziCell.swift
//  Chino
//
//  Created by Yangyang on 2017/3/30.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class HanziCell: UICollectionViewCell {
    
    @IBOutlet weak var lbPinyin: UILabel!
    @IBOutlet weak var lbHanzi: UILabel!
    
    override func awakeFromNib() {
        if UIScreen.main.bounds.size.width <= 320 {
            self.lbHanzi.font = UIFont.systemFont(ofSize: 30)
        }
    }
    
    func configWith(model: HanziModel) {
        self.lbHanzi.text = model.hanzi
        self.lbPinyin.text = model.pinyin
    }
}
