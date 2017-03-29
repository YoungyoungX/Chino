//
//  FirstViewController.swift
//  Chino
//
//  Created by Shiyangyang on 2017/3/26.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FirstViewController: UIViewController {


    @IBOutlet weak var mainCollection: UICollectionView!

    private var nativeExpressView: GADNativeExpressAdView?

    override func viewDidLoad() {
        super.viewDidLoad()

        mainCollection.backgroundColor = UIColor.chabai
        nativeExpressView?.adUnitID = "ca-app-pub-3940256099942544/2562852117"
        nativeExpressView?.rootViewController = self

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
}

