//
//  ChinoWebViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/3.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class ChinoWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!//no WKWebView in Swift?
    
    private var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = URLRequest.init(url: self.url)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configUrl(url: URL, isLocal: Bool) {
        if (url.absoluteString.characters.count) > 0 {
            self.url = url
        }else{
            print("Bad url")
        }
    }
}
