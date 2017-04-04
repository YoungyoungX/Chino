//
//  RegisterViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/3/31.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import LeanCloud

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BtnRegisterPressed(_ sender: UIButton) {
        
        let newUser = LCUser()
        if (tfUsername.text?.characters.count)! < 6 {
            tfUsername.text = "Too short!"
            return;
        }
        
        if (tfPassword.text?.characters.count)! < 8 {
            tfPassword.text = "Too short!"
            return;
        }
        
        newUser.username = LCString(tfUsername.text!)
        newUser.password = LCString(tfPassword.text!)
        newUser.signUp { (result) in
            switch result{
            case .success:
                print("sign up success")
                
                break
                case .failure(error:):
                    print("failed to sign up: error")
                break
            }
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
