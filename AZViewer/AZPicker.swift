//
//  AZPicker.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/6/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

class AZPicker: AZView{
    
    // public
    var data: [[(AnyObject, String)]] = [[]] {
        didSet{
            self.pickerView.reloadAllComponents()
        }
    }
    
    var delegate: AZPickerViewDelegate?
    
    // private
    var pickerView: UIPickerView = UIPickerView()
    
    // override
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){
        
        self.prepareHeaderSection(title: "")
        
        self.preparePickerView()
    }
    
    // prepare pickerview
    fileprivate func preparePickerView(){
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.addSubview(self.pickerView)
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self.pickerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: AZStyle.sectionHeaderHeight).isActive = true
        NSLayoutConstraint(item: self.pickerView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.pickerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.pickerView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
    }
}

extension AZPicker: UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return self.data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.data[component].count
    }
}

extension AZPicker: UIPickerViewDelegate{
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.data[component][row].1
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.delegate?.aZPickerView(didSelectRow: row, inComponent: component)
    }
}

extension AZPicker{
    
    override func closeView() {
        
        super.closeView()
        self.removeFromSuperview()
    }
}
