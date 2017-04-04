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

    private var dataSource: Array<Dictionary<String, Any>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = Array.init()
        self.getDataSource(local: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataSource(local: Bool) {
        if local {
            var top100 = ["title":"Top 100 characters","body":"The most used and easist 100 Chinese characters.","action":"toHanzi100"]
            self.dataSource.append(top100)
            top100 = ["title":"Orientation","body":"Learn the orientation in Chinese(East, West, South, North)","action":"toOrientation"]
            self.dataSource.append(top100)
        }
    }
    
    func openWebWith(url: URL, local: Bool) {//need set isLocal
        let storyboard = UIStoryboard.init(name: "Wiki", bundle: nil)
        let webVC = storyboard.instantiateViewController(withIdentifier: "webVC") as! ChinoWebViewController
        Logger().debug("filePath = ", url)
        webVC.configUrl(url: url, isLocal: local)
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    
    
    func getHanzi(toNumber: NSNumber) -> Array<Any>{
        var hanziArray = Array<Any>.init()
        let csvPath = Bundle.main.path(forResource: "hanzi500", ofType: "csv")
        
        if csvPath == nil {
            Logger().debug("The hanzi file path is nil.")
            return hanziArray
        }
        var csvData: String? = nil
        do {
            csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            let csv = csvData?.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
            for row in csv!{
                if !row.isEmpty {
                    let components = row.components(separatedBy: ",")
                    let hanzi = HanziModel.init(id: components.first!, character: components[1], Pinyin: "NotDefined")
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
        return (dataSource?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WikiCell", for: indexPath) as! WikiCell
        let dict = self.dataSource[indexPath.row] as Dictionary
        cell.configChinoColor(color: UIColor.dai, title: dict["title"] as! String, body: dict["body"] as! String)
        
        return cell
    }
    
    //MARK: collectionView flowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - 10 * 2)
        
        return CGSize.init(width: cellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = self.dataSource[indexPath.row]
        let action = dict["action"] as! String
        if action == "toHanzi100" {
            let storyboard = UIStoryboard.init(name: "Wiki", bundle: nil)
            let hanziVC = storyboard.instantiateViewController(withIdentifier: "HanziListViewController") as! HanziListViewController
            hanziVC.configWithHanziSource(source: "Top100")
            self.navigationController?.pushViewController(hanziVC, animated: true)
            
        }else if action == "toOrientation" {
            let filePath = Bundle.main.path(forResource: "orientation", ofType: "html")
            let localUrl = URL.init(string: filePath!)
            self.openWebWith(url: localUrl!, local: true)
        }
        
    }
    
}

