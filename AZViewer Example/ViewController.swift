//
//  ViewController.swift
//  AZViewer Example
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit
import AZViewer

class ViewController: UIViewController {

    var pickerView: AZPopupPickerView = AZPopupPickerView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGray
        
        self.preparePickerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // prepare picker view
    fileprivate func preparePickerView(){
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.data = [[(12 as AnyObject, "آیتم ۱"), (13 as AnyObject, "ایتم دوم"), (14 as AnyObject, "آیتم 3")],[(1  as AnyObject, "آیتم"), (2 as AnyObject, "آیتم 5")], [(3 as AnyObject, "آیتم 3"), (6 as AnyObject, "آیتم 6")]]
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

