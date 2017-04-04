//
//  SecondViewController.swift
//  Chino
//
//  Created by Shiyangyang on 2017/3/26.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import LeanCloud
import Log

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainCollection: UICollectionView!

    private var hanziArray: Array<HanziModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
        hanziArray = Array.init()
        self.read500Hanzi()
        
        let storyboard = UIStoryboard.init(name: "Wiki", bundle: nil)
        let webVC = storyboard.instantiateViewController(withIdentifier: "webVC") as! ChinoWebViewController
        let filePath = Bundle.main.path(forResource: "orientation", ofType: "html")
        Logger().debug("filePath = ", filePath!)
        webVC.configUrl(url: URL.init(string: filePath!)!, or: "")
        self.present(webVC, animated: false) { 
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read500Hanzi() {
        let csvPath = Bundle.main.path(forResource: "hanzi500", ofType: "csv")
        if csvPath == nil {
            return
        }
        var csvData: String? = nil
        do {
            csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            let csv = csvData?.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
            for row in csv!{
                if !row.isEmpty {
                    let components = row.components(separatedBy: ",")
                    let hanzi = HanziModel.init(id: components.first!, character: components[1], Pinyin: "NotDefined")
                    hanziArray?.append(hanzi)
                }
            }
            print("HanziArray count = " + String.init(describing: hanziArray?.count))
            if (hanziArray?.count)! > 0 {
                mainCollection.reloadData()
            }
            
        } catch{
            print(error)
        }
    }
    
    func fetchData() {
////        let result:LCResultType
//        let query = LCQuery(className: "MYOBJ")
//        let date = LCDate.init()
//        query.whereKey("createdAt", .notEqualTo(date))
//        query.find { result  in
//            switch result {
//            case .success(let objects):
//                print(objects.count)
//            break // 查询成功
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    //MARK: collectionView datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (hanziArray?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hanziCell", for: indexPath) as! HanziCell
        let hanzi = hanziArray?[indexPath.row]
        cell.lbHanzi.text = hanzi?.hanzi
        return cell
    }
    
    //MARK: collectionView flowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - 10 * 5)/4
        
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

