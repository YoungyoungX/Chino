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

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GADNativeExpressAdViewDelegate {


    @IBOutlet weak var mainCollection: UICollectionView!

    private var nativeExpressView: GADNativeExpressAdView?
    private var adArray: Array<Any>?

    override func viewDidLoad() {
        super.viewDidLoad()

        adArray = Array.init()
        mainCollection.backgroundColor = UIColor.chabai
        self.requestAdMobAd()
        

    }
    
    func fetchChinoDataFrom(date: NSData) {
        let query = LCQuery(className: "ChinoData")
        let date = LCDate.init()
        query.whereKey("createdAt", .notEqualTo(date))
        query.find { result  in
            switch result {
            case .success(let objects):
                print(objects.count)
            break // 查询成功
            case .failure(let error):
                print(error)
            }
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
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chinoCell", for: indexPath) as! ChinoCell
        if indexPath.row%5 == 0 && indexPath.row > 0 && (adArray?.count)! > 0 {
            let adView = adArray![0] as! UIView
            cell .addSubview(adView)
            cell.colorLiner.backgroundColor = UIColor.yingwulv
            
        }
        cell.layer.shadowColor = UIColor.dai.cgColor
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
        mainCollection.reloadData()
    }
    
    func nativeExpressAdView(_ nativeExpressAdView: GADNativeExpressAdView, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError:", error)
    }
}

