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

//    var popupView: AZPopupView = AZPopupView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 30))
    var checkBoxView: AZCheckBox = AZCheckBox()
    var pickerView: AZPickerView = AZPickerView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 30))
    var button: AZButton = AZButton(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.popupView)
//        self.view.addSubview(self.checkBoxView)
    
        self.preparePickerView()
        self.prepareButton()
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
        self.pickerView.data = [[(12 as AnyObject, "Item 1"), (13 as AnyObject, "Item 2"), (14 as AnyObject, "Item 3")],[(1  as AnyObject, "Item4"), (2 as AnyObject, "Item 5")], [(3 as AnyObject, "Section 3"), (6 as AnyObject, "Item 6")]]
        self.pickerView.separatorSection = " - - "
        self.pickerView.selected(indexPath: IndexPath(row: 2, section: 0))
        print("selected index: \(self.pickerView.index)")
    }
    
    fileprivate func prepareButton(){
        
        self.button.backgroundColor = UIColor.orange
        
        self.button.setTitle("Button", for: .normal)
        //        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        self.view.addSubview(self.button)
        self.button.loader = true
    }
}

extension ViewController: AZPickerViewDelegate{
    func aZPickerView(didSelectRow row: Int, inComponent component: Int) {
        print("change index: \(component) \(row) index: \(self.pickerView.index)")
    }
}

