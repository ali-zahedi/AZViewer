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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.popupView)
        self.view.addSubview(self.checkBoxView)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}

