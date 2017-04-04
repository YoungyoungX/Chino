//
//  UploaderViewController.swift
//  Chino
//
//  Created by Yangyang on 2017/4/2.
//  Copyright © 2017年 shiyangyang. All rights reserved.
//

import UIKit
import LeanCloud

class UploaderViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var displayCard: UIView!
    @IBOutlet weak var tvDisplay: UITextView!
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var tfMain: UITextField!

    @IBOutlet weak var btnOK: UIButton!
    private var contentOrder: NSInteger!
    private var currentModel: ChinoHanziModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shadow
        let shadowPath = UIBezierPath(rect: self.displayCard.bounds).cgPath
        self.displayCard.layer.shadowColor = UIColor(white: 0.7, alpha: 0.7).cgColor
        self.displayCard.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        self.displayCard.layer.shadowOpacity = 0.4
        self.displayCard.layer.masksToBounds = false
        self.displayCard.layer.shadowPath = shadowPath
        //
        self.contentOrder = 0;
        self.currentModel = ChinoHanziModel()
    }

    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func displayCardWith(model: ChinoHanziModel) {
        if model.hanzi == nil{
            return
        }
        var text = model.hanzi.value
        text = text + "  " + model.hanziPY.value + "\n"
        if (model.hanziEng != nil) {
            text = text + model.hanziEng.value + "\n"
            if (model.words != nil){
                text = text + model.words.value + "\n"
                if (model.wordsEng != nil) {
                    text = text + model.wordsEng.value + "\n"
                    if model.sentence != nil {
                        text = text + model.sentence.value + "\n"
                        if model.sentenceEng != nil {
                            text = text + model.sentenceEng.value
                            self.btnOK .setTitle("上传", for: UIControlState.normal)
                            self.btnOK.backgroundColor = UIColor.dai
                            self.tfMain.resignFirstResponder()
                        }
                    }
                }
            }
        }
        self.tvDisplay.text = text
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tfMain.resignFirstResponder()
    }
    
    @IBAction func btnUpPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "上传"{
            self .uploadModel(model: self.currentModel)
            return
        }
        if (self.tfMain.text?.characters.count)! > 0{
            let text = LCString.init(self.tfMain.text!)
            switch self.contentOrder {
            case 0:
                self.currentModel.hanzi = text
                let pinyin = PinyinTool.hanziToPinyin(hanzi: self.tfMain.text)
                self.currentModel.hanziPY = LCString.init(pinyin)
                self.tfMain.text = nil
                break
            case 1:
                self.currentModel.hanziEng = text
                self.tfMain.text = nil
                break
            case 2:
                self.currentModel.words = text
                self.tfMain.text = nil
                break
            case 3:
                self.currentModel.wordsEng = text
                self.tfMain.text = nil
                break
            case 4:
                self.currentModel.sentence = text
                self.tfMain.text = nil
                break
            case 5:
                self.currentModel.sentenceEng = text
                self.tfMain.text = nil
                break
            default:
                break
            }
            self.contentOrder = self.contentOrder + 1
            self.displayCardWith(model: self.currentModel)
        }else{
            
        }
        
    }
    
    
    @IBAction func segementValueChanged(_ sender: UISegmentedControl) {
        
    }
    
    func uploadModel(model: ChinoHanziModel) {
        let result = model.save()
        if result.isSuccess == true {
            self.tvDisplay.text = "上传成功！"
        }else{
            self.tfMain.text = "上传失败！"
        }
    }
    
    
}
