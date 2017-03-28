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
    public var separatorSection: String = "/"
    public var index: [Int: Int]{
        get{
            return self._index
        }
    }
    
    public var data: [[(AnyObject, String)]] = [[]] {
        didSet{
            self.pickerView.data = self.data
            self._index = [:]
            for (i, _) in self.data.enumerated(){
                // check out of range
                if self.data[i].count > 0{
                    self.selected(indexPath: IndexPath(row: 0, section: i))
                }
            }
        }
    }
    
    public var delegate: AZPickerViewDelegate?
    
    
    // private
    fileprivate var _index: [Int: Int]!
    fileprivate var pickerView: AZPicker = AZPicker()
    fileprivate var input: UITextField = UITextField()
    
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
        self.prepareInputPickerView()
    }
    
    // prepare pickerview
    fileprivate func preparePickerView(){
        
        self.pickerView.delegate = self
        
        self.pickerView.translatesAutoresizingMaskIntoConstraints = true
        
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 120
        let position = CGPoint(x: 0, y: UIScreen.main.bounds.height - height)
        
        self.pickerView.frame.size = CGSize(width: width, height: height)
        self.pickerView.frame.origin =  position
        
    }
    
    fileprivate func prepareInputPickerView(){
        
        self.input.addTarget(self, action: #selector(inputPickerViewAction), for: .touchDown)
        self.input.font = AZStyle.sectionInputFont
        self.input.textAlignment = .center
        self.input.tintColor = UIColor.clear
        self.input.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.input)
        
        NSLayoutConstraint(item: self.input, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.input, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.input, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.input, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
    }
    
    // tap on input
    func inputPickerViewAction(){
        
        // check for load all data and then show
        if self.index.count == self.data.count {
            var view: UIView = self
            while let v =  view.superview{
                view = v
            }
            
            view.addSubview(self.pickerView)
        }else{
            NSLog("AZPicker View data doesn't load ")
        }
        
    }
    
}

extension AZPickerView: AZPickerViewDelegate {
    
    public func aZPickerView(didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.aZPickerView(didSelectRow: row, inComponent: component)
        self._index[component] = row
        
        
        var string = ""
        
        for i in 0...(self.data.count - 1){
            
            // check array range
            if let row = self.index[i],  self.data[i].count > row{
                
                string += self.data[i][row].1 + self.separatorSection
            }
        }
        
        string = string.trimmingCharacters(in: CharacterSet(charactersIn: self.separatorSection))
        self.input.text = string
    }
    
    public func selected(indexPath: IndexPath){
        self.pickerView.pickerView.selectRow(indexPath.row, inComponent: indexPath.section, animated: true)
        self.pickerView.pickerView(self.pickerView.pickerView, didSelectRow: indexPath.row, inComponent: indexPath.section)
    }
    
}
