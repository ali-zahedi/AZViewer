//
//  AZPickerView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/6/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZPickerView: AZView{
    
    // public
    public var pickerData: [String] = [] {
        didSet{
            self.pickerView.pickerData = self.pickerData
        }
    }
    
    public var delegate: AZPickerViewDelegate?
    
    // private
    fileprivate var pickerView: AZPicker = AZPicker()
    
    // override
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){

        self.preparePickerView()
    }
    
    // prepare pickerview
    fileprivate func preparePickerView(){
        
        self.pickerView.delegate = self
        
        self.pickerView.translatesAutoresizingMaskIntoConstraints = true
        
        // TODO: Add uipicker view to add main view

        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 120
        let position = CGPoint(x: 0, y: UIScreen.main.bounds.height - height)
        
        self.pickerView.frame.size = CGSize(width: width, height: height)
        self.pickerView.frame.origin =  position
        self.addSubview(self.pickerView)
    }
    
}

extension AZPickerView: AZPickerViewDelegate {
    
    public func AZPickerView(didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.AZPickerView(didSelectRow: row, inComponent: component)
    }
    
}
