//
//  WikiCell.swift
//  Chino
//
//  Created by Yangyang on 2017/4/4.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class WikiCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    private var chinoColor: UIColor?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 6.0
    }
    
    func configChinoColor(color: UIColor, title:String, body:String) {
        self.chinoColor = color
        self.backgroundColor = chinoColor
        
        self.lbTitle.text = title
        self.lbDesc.text = body
    }
    

}

