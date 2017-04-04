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
            let entry1 = ["title":"Top 100 characters","body":"The most used and easist 100 Chinese characters.","action":"toHanzi","toHanzi":100] as [String : Any]
            let entry2 = ["title":"Top 500 characters","body":"Top 500 Chinos, take it easy!","action":"toHanzi","toHanzi":500] as [String : Any]
            let entry3 = ["title":"Orientation","body":"Learn the orientation in Chinese(East, West, South, North)","action":"toLocalFile","toLocalFile":"orientation"]
            self.dataSource = [entry1, entry2, entry3]
        }
    }
    
    func openWebWith(url: URL, local: Bool) {//need set isLocal
        let storyboard = UIStoryboard.init(name: "Wiki", bundle: nil)
        let webVC = storyboard.instantiateViewController(withIdentifier: "webVC") as! ChinoWebViewController
        Logger().debug("filePath = ", url)
        webVC.configUrl(url: url, isLocal: local)
        self.navigationController?.pushViewController(webVC, animated: true)
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
        if action == "toHanzi" {
            let storyboard = UIStoryboard.init(name: "Wiki", bundle: nil)
            let hanziVC = storyboard.instantiateViewController(withIdentifier: "HanziListViewController") as! HanziListViewController
            hanziVC.configWithHanziTo(num: dict["toHanzi"] as! NSNumber)
            self.navigationController?.pushViewController(hanziVC, animated: true)
            
        }else if action == "toLocalFile" {
            let filePath = Bundle.main.path(forResource: dict["toLocalFile"] as? String, ofType: "html")
            let localUrl = URL.init(string: filePath!)
            self.openWebWith(url: localUrl!, local: true)
        }
        
    }
    
}

