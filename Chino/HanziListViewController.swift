//
//  HanziListViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/4.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class HanziListViewController: ChinoBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: Array<Any>!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = Array.init()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configWithHanziSource(source: String) {
        
    }

}
