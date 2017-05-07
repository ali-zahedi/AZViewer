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
    var button: AZButton = AZButton(frame: CGRect(x: 0, y: 170, width: UIScreen.main.bounds.width, height: 50))
    var stopAnimationButton: AZButton = AZButton(frame: CGRect(x: 0, y: 230, width: UIScreen.main.bounds.width, height: 50))
    
    var checkBoxView: AZCheckBox = AZCheckBox(frame: CGRect(x: 0, y: 290, width: UIScreen.main.bounds.width, height: 190))
    var radioButtonView: AZRadioButton = AZRadioButton(frame: CGRect(x: 0, y: 490, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGray
        
        self.preparePickerView()
        self.prepareDatePickerView()
        self.prepareStepper()
        self.prepareButton()
        self.prepareCheckBox()
        self.prepareRadioButton()
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
        self.prepareNotification()
    }
    
    // prepare picker view
    fileprivate func preparePickerView(){
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.data = [[(12 as AnyObject, "آیتم ۱"), (13 as AnyObject, "ایتم دوم"), (14 as AnyObject, "آیتم 3")],[(1  as AnyObject, "آیتم"), (2 as AnyObject, "آیتم 5")], [(3 as AnyObject, "آیتم 3"), (6 as AnyObject, "آیتم 6")]]
        self.pickerView.separatorSection = " / "
//        self.pickerView.popup.header.leftButtonTintColor
        self.pickerView.selected(indexPath: IndexPath(row: 2, section: 0))
        self.pickerView.loader.horizontalAlignment = .right
        self.pickerView.loader.isActive = true
        print("selected index: \(self.pickerView.index)")
//        self.pickerView
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
        print(self.datePickerView.date)
    }
    
    
    fileprivate func prepareStepper(){
        self.view.addSubview(self.stepper)
        self.stepper.delegate = self
        //        self.stepper.minusBackgroundColor
        //        self.stepper.minusIcon
        //        self.stepper.minusIconColor
        //        self.stepper.plusBackgroundColor
        //        and so on...
    }
    
    fileprivate func prepareButton(){
        
        self.button.backgroundColor = UIColor.orange
        
        self.button.setTitle("Button", for: .normal)
        self.button.addTarget(self, action: #selector(self.tapOnButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(self.button)
        
        self.stopAnimationButton.backgroundColor = UIColor.red
        self.stopAnimationButton.setTitle("Stop Animation", for: .normal)
        self.stopAnimationButton.addTarget(self, action: #selector(tapOnStopAnimationButtonAction(_:)), for: .touchUpInside)
        self.stopAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.stopAnimationButton)
        
        _ = self.stopAnimationButton.aZConstraints.parent(parent: self.view).top(to: self.button, toAttribute: .bottom).right().left().height(constant: 50)
    }
    
    func tapOnStopAnimationButtonAction(_ sender: AZButton){
        self.button.loader = false
    }
    
    func tapOnButtonAction(_ sender: AZButton){
        sender.loader = true
    }
    
    // notification
    fileprivate func prepareNotification(){
        AZNotification.shared.show(msg: "لورم ایپسوم یا طرح‌نما (به انگلیسی: Lorem ipsum) به متنی آزمایشی و بی‌معنی در صنعت چاپ، صفحه‌آرایی و طراحی گرافیک گفته می‌شود.", type: .success, hideAfterSeconds: 3)
    }
    
    // check box
    fileprivate func prepareCheckBox(){
        
        self.view.addSubview(self.checkBoxView)
        var source: [AZCheckBoxDataSource] = []
        
        source.append(AZCheckBoxDataSource(id: "1" as AnyObject, title: "title 1", isActive: false))
        source.append(AZCheckBoxDataSource(id: "2" as AnyObject, title: "title 2", isActive: true))
        source.append(AZCheckBoxDataSource(id: "3" as AnyObject, title: "title 3", isActive: false))
        source.append(AZCheckBoxDataSource(id: "4" as AnyObject, title: "title 4", isActive: false))
        
        let section: AZCheckBoxDataSection = AZCheckBoxDataSection(value: source)
     
        self.checkBoxView.data = section
        
        self.checkBoxView.activeStyle.tintColor = UIColor.black
        self.checkBoxView.diActiveStyle.backgroundColor = UIColor.black
        // and so on...
    }
    
    // radio button
    fileprivate func prepareRadioButton(){
        
        self.view.addSubview(self.radioButtonView)
        var source: [AZCheckBoxDataSource] = []
        
        source.append(AZCheckBoxDataSource(id: "1" as AnyObject, title: "title 1", isActive: false))
        source.append(AZCheckBoxDataSource(id: "2" as AnyObject, title: "title 2", isActive: true))
        source.append(AZCheckBoxDataSource(id: "3" as AnyObject, title: "title 3", isActive: false))
        source.append(AZCheckBoxDataSource(id: "4" as AnyObject, title: "title 4", isActive: false))
        
        let section: AZCheckBoxDataSection = AZCheckBoxDataSection(value: source)
        
        self.radioButtonView.data = section
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

// stepper delegate
extension ViewController: AZStepperDelegate{
    func aZStepper(changeValue: Int) {
        print("change stepper value to : \(changeValue)")
    }
}
