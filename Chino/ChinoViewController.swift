//
//  FirstViewController.swift
//  Chino
//
//  Created by Shiyangyang on 2017/3/26.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import GoogleMobileAds
import LeanCloud
import ReachabilitySwift

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GADNativeExpressAdViewDelegate {


    @IBOutlet weak var mainCollection: UICollectionView!
    private var refreshControl: UIRefreshControl!
    private var dataSource: Array<Any>!
    private var nativeExpressView: GADNativeExpressAdView?
    private var adLoaded: Bool!
    private var adArray: Array<GADNativeExpressAdView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action:  #selector(self.refreshData), for: .valueChanged)
        self.mainCollection.addSubview(refreshControl)
        
        self.dataSource = Array.init()
        adArray = Array.init()
        self.adLoaded = false
        mainCollection.backgroundColor = UIColor.chabai
        self.requestAdMobAd()
        self.refreshData()
    }
    
    func fetchChinoDataFrom(chinoDate: LCNumber, complete:@escaping (_ success: Bool, _ dataArray: Array<Any>?)->Void) {
        let query = LCQuery(className: "ChinoHanziModel")
        query.whereKey("createdAt", .lessThan(LCDate.init(NSDate.init() as Date)))
        query.whereKey("chinoDate", .descending)
        query.limit = 30
        query.find { result  in
            switch result {
            case .success(let objects):
                complete(true, objects)
            break // 查询成功
            case .failure(let error):
                print("FetchChinoData error: ", error)
                complete(false, nil)
            }
        }
        
    }
    
    func refreshData() {
        if (Reachability()?.isReachable)! {
            self.fetchChinoDataFrom(chinoDate: 20170331, complete: {[unowned self] (success, dataArray) in
                if success == true {
                    self.dataSource = dataArray
                    self.mainCollection.reloadData()
                }else{
                    print("empty")
                }
                self.refreshControl.endRefreshing()
            })
            
        }else{
            print("No net work")
            self.refreshControl.endRefreshing()
        }
    }
    
    func getLocalChinoData() {
        
    }
    
    
    func requestAdMobAd() {
        nativeExpressView = GADNativeExpressAdView.init(frame: CGRect.init(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 10 * 2 - 10, height: 150))
        nativeExpressView?.adUnitID = "ca-app-pub-3940256099942544/2562852117"
        nativeExpressView?.rootViewController = self
        nativeExpressView?.delegate = self
        let request = GADRequest()
        nativeExpressView?.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Reporter.LogEventWithName(event: "firstVCAppear", paremeters: nil)
    }
    
    //MARK: CollectionView datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        let count = self.dataSource.count
//        return count/12 + (count%12 > 0 ? 1 : 0);
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section < section - 1 {
//            return self.dataSource.count%12
//        }
//        return 13;
        if self.dataSource.count <= 12 {
            return self.dataSource.count
        }
        return self.dataSource.count + (self.adLoaded == true ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chinoCell", for: indexPath) as! ChinoCell
        if self.adLoaded! && indexPath.row == 12 {
            cell.colorLiner.backgroundColor = UIColor.yingwulv
            cell.addSubview((self.adArray?[0])!)
        }else{
            var ROW = indexPath.row
            if ROW > 12 {
                ROW = ROW - (self.adLoaded! ? 1 : 0)
            }
            let model = self.dataSource[ROW] as! ChinoHanziModel
            cell.congifWithChinoModel(model: model, color: UIColor.yanzhi)
        }
        
        let shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowColor = UIColor(white: 0.7, alpha: 0.7).cgColor
        cell.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = shadowPath
        cell.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        return cell;
        
    }
    
    //MARK: CollectionView flowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width - 10 * 2, height: 150);
    }
    
    //MARK: GADNativeExpressAdViewDelegate
    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        adArray?.append(nativeExpressAdView)
        self.adLoaded = true
        self.mainCollection.reloadData()
    }
    
    func nativeExpressAdView(_ nativeExpressAdView: GADNativeExpressAdView, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError:", error)
    }
}

