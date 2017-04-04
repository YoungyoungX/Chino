//
//  HanziListViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/4.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class HanziListViewController: ChinoBaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    @IBOutlet weak var mainCollection: UICollectionView!
    
    private var dataSource: Array<HanziModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainCollection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configWithHanziTo(num: NSNumber) {
        self.dataSource = self.getHanzi(toNumber: num) as! Array<HanziModel>
    }

    
    func getHanzi(toNumber: NSNumber) -> Array<Any>{
        var hanziArray = Array<Any>.init()
        let csvPath = Bundle.main.path(forResource: "Top500", ofType: "csv")
        if csvPath == nil {
            return hanziArray
        }
        var csvData: String? = nil
        do {
            csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            let csv = csvData?.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
            for row in csv!{
                if !row.isEmpty {
                    let components = row.components(separatedBy: ",")
                    let hanzi = HanziModel.init(id: components.first!, character: components[1], Pinyin: PinyinTool.hanziToPinyin(hanzi: components[1]))
                    hanziArray.append(hanzi)
                    if hanziArray.count == toNumber.intValue {
                        break
                    }
                }
            }
            print("HanziArray count = " + String.init(describing: hanziArray.count))
        } catch{
            print(error)
        }
        return hanziArray
    }
    
    //MARK: - colletcitionView dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HanziCell", for: indexPath) as! HanziCell
        let hanzi = self.dataSource[indexPath.row] 
        cell.configWith(model: hanzi)
        return cell
    }
    
    //MARK: - colletcitionView flowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - 10 * 5)/4 - 0.01
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 0, height: 10)
    }
}
