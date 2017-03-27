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
    var pickerView: AZPickerView = AZPickerView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.popupView)
//        self.view.addSubview(self.checkBoxView)
    
        self.preparePickerView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // prepare picker view
    fileprivate func preparePickerView(){
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.data = [["Item 1", "Item 2", "Item 3"], ["Item4", "Item 5"], ["Section 3", "Item 6"]]
        self.pickerView.separatorSection = " - - "
        self.pickerView.selected(indexPath: IndexPath(row: 2, section: 0))
        print("selected index: \(self.pickerView.index)")
    }
}

extension ViewController: AZPickerViewDelegate{
    func aZPickerView(didSelectRow row: Int, inComponent component: Int) {
        print("change index: \(component) \(row) index: \(self.pickerView.index)")
    }
}

