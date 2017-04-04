//
//  ChinoWebViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/3.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit

class ChinoWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    private var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = URLRequest.init(url: self.url)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configUrl(url: URL, or filePath: String) {
        if (url.absoluteString.characters.count) > 0 {
            self.url = url
        }else if filePath.characters.count > 0 {
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
