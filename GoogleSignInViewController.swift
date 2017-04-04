//
//  GoogleSignInViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/2.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import Firebase
import Log

class GoogleSignInViewController: UIViewController, GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signInSilently()
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signOut()
//            GIDSignIn.sharedInstance().signIn()
        } else {
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @IBAction func btnSignInPressed(_ sender: GIDSignInButton) {
        Logger().debug("Did press signButton")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self .present(viewController, animated: false) { 
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController .dismiss(animated: false) { 
            Logger().debug("SignIn dismiss VC");
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        Logger().debug("SignIn will dispatch, error : ", error)
    }

}
