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
    var datePickerView: AZPopupDatePickerView = AZPopupDatePickerView(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 30))
    var stepper: AZStepper = AZStepper(frame: CGRect(x: 30, y: 130, width: UIScreen.main.bounds.width / 4, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGray
        
        self.preparePickerView()
        self.prepareDatePickerView()
        self.prepareStepper()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // did appear
    override func viewDidAppear(_ animated: Bool) {
//        let loader = AZLoader()
//        loader.isActive = true
        // or 
        AZLoader.shared.isActive = true
    }
    
    // prepare picker view
    fileprivate func preparePickerView(){
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.data = [[(12 as AnyObject, "آیتم ۱"), (13 as AnyObject, "ایتم دوم"), (14 as AnyObject, "آیتم 3")],[(1  as AnyObject, "آیتم"), (2 as AnyObject, "آیتم 5")], [(3 as AnyObject, "آیتم 3"), (6 as AnyObject, "آیتم 6")]]
        self.pickerView.separatorSection = " / "
        self.pickerView.selected(indexPath: IndexPath(row: 2, section: 0))
        self.pickerView.loader.horizontalAlignment = .right
        self.pickerView.loader.isActive = true
        print("selected index: \(self.pickerView.index)")
    }
    
    // prepare date picker view
    fileprivate func prepareDatePickerView(){
        self.view.addSubview(self.datePickerView)
//        self.pickerView.delegate = self
        
        self.datePickerView.separatorSection = " / "
        self.datePickerView.selected(indexPath: IndexPath(row: 0, section: 0))
        
        // date
        let formatter = DateFormatter()
        formatter.dateFormat = AZStyle.shared.sectionDatePickerViewFormatDate
        formatter.calendar = Calendar(identifier: .gregorian)
        self.datePickerView.minimumDateTime = formatter.date(from: "1990/12/10")!
        self.datePickerView.maximumDateTime = formatter.date(from: "2017/12/31")!
        self.datePickerView.icon = UIImage(named: "calender")
//        print("selected index: \(self.datePickerView.index)")
    }

    
    fileprivate func prepareStepper(){
        self.view.addSubview(self.stepper)
        //        self.stepper.minusBackgroundColor
        //        self.stepper.minusIcon
        //        self.stepper.minusIconColor
        //        self.stepper.plusBackgroundColor
        //        and so on...
    }
}

extension ViewController: AZPopupViewDelegate{
    
    func submitPopupView() {
        print("change index: \(self.pickerView.index)")
    }
    
    func cancelPopupView() {
        // nothing happend
    }
}
