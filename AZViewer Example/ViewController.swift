//
//  ViewController.swift
//  AZViewer
//
//  Created by Ali Zahedi on 03/01/2017.
//  Copyright (c) 2017 Ali Zahedi. All rights reserved.
//

import UIKit
import AZViewer

class ViewController: UIViewController {

    var popupView: AZPopupView = AZPopupView()
    var checkBoxView: AZCheckBox = AZCheckBox()
    var pickerView: AZPickerView = AZPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.popupView)
//        self.view.addSubview(self.checkBoxView)
    
        self.view.addSubview(self.pickerView)
        self.pickerView.pickerData = ["Ali", "Jafar", "Hasa"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}

