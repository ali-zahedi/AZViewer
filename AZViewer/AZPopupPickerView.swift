//
//  AZPickerView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/6/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZPopupPickerView: AZView{
    
    // MARK: Public
    public var popup: AZPicker = AZPicker()
    public var separatorSection: String = "/" {
        didSet{
            self.submitPopupView()
        }
    }
    public var index: [Int: Int]{
        get{
            return self._index
        }
    }
    
    public var data: [[(AnyObject, String)]] = [[]] {
        didSet{
            self.popup.data = self.data
            // for restor after load dynamic another component
            let index = self._indexTemp
            self._index = [:]
            self._indexTemp = [:]
            for (i, _) in self.data.enumerated(){
                // check out of range
                if self.data[i].count > 0{
                    
                    // restore last position
                    if index.count > i, self.data[i].count > index[i]! {
                        
                        self.selected(indexPath: IndexPath(row: index[i]!, section: i))
                    }else{
                       
                        self.selected(indexPath: IndexPath(row: 0, section: i))
                    }
                }
            }
        }
    }
    public var icon: UIImage! {
        didSet{
            self.input.leftIcon = icon
        }
    }
    
    public var delegate: AZPopupViewDelegate?
    
    public var titleFont: UIFont!{
        didSet{
            self.input.font  = self.titleFont
        }
    }
    
    public var pickerFont: UIFont!{
        didSet{
            self.popup.font = self.pickerFont
        }
    }
    
    public var pickerColor: UIColor!{
        didSet{
            self.popup.color = self.pickerColor
        }
    }
    // private
    fileprivate var _index: [Int: Int] = [:]
    fileprivate var _indexTemp: [Int: Int] = [:]
    fileprivate var input: AZLabelIcon = AZLabelIcon()
    
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
        
        for v in [input] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.preparePickerView()
        self.prepareInputPickerView()
    }
    
}

// prepare 
extension AZPopupPickerView{
    
    // pickerview
    // TODO: Check
    fileprivate func preparePickerView(){
        
        self.popup.delegate = self
        self.popup.delegatePopupView = self
        self.popup.translatesAutoresizingMaskIntoConstraints = true
        
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 120
        let position = CGPoint(x: 0, y: UIScreen.main.bounds.height - height)
        
        self.popup.frame.size = CGSize(width: width, height: height)
        self.popup.frame.origin =  position
        
        self.pickerColor = self.style.sectionPickerViewItemColor
        self.pickerFont = self.style.sectionPickerViewItemFont
    }
    
    // input
    fileprivate func prepareInputPickerView(){
        
        //self.input.addTarget(self, action: #selector(inputPickerViewAction), for: .touchDown)
        // add gesture
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(inputPickerViewAction(gr:)))
        tap.delegate = self
        self.input.addGestureRecognizer(tap)
        self.input.isUserInteractionEnabled = true
        
        self.titleFont = self.style.sectionInputFont
        self.input.textAlignment = .center
        self.input.tintColor = UIColor.clear
        
        _ = self.input.aZConstraints.parent(parent: self).top().right().left().bottom()
        self.input.leftIcon = AZAssets.expandImage
    }
    
}

extension AZPopupPickerView: AZPickerViewDelegate {
    
    public func aZPickerView(didSelectRow row: Int, inComponent component: Int) {
        self._indexTemp[component] = row
    }
    
    public func selected(indexPath: IndexPath){
        self.selectedWithoutSubmit(indexPath: indexPath)
        self.submitPopupView()
    }
    
    fileprivate func selectedWithoutSubmit(indexPath: IndexPath){
        self.popup.pickerView.selectRow(indexPath.row, inComponent: indexPath.section, animated: true)
        self.popup.pickerView(self.popup.pickerView, didSelectRow: indexPath.row, inComponent: indexPath.section)
    }
    
}

// popupview
extension AZPopupPickerView: AZPopupViewDelegate{
    
    // submit
    public func submitPopupView() {

        // set index
        self._index = self._indexTemp
        
        // show on input
        var string = ""
        
        for i in (0...(self.data.count - 1)){
            
            // check array range
            if let row = self.index[i],  self.data[i].count > row{
                
                string += self.data[i][row].1 + self.separatorSection
            }
        }
        
        string = string.trimmingCharacters(in: CharacterSet(charactersIn: self.separatorSection))
        self.input.text = string
        
        // call delegate
        self.delegate?.submitPopupView()
    }
    
    // cancel
    public func cancelPopupView() {
        
        // reset index
        if self._index == self._indexTemp{
            
            return
        }
        self._indexTemp = self._index
        
        for (i, _) in self.data.enumerated(){
            // check array range
            if let row = self.index[i],  self.data[i].count > row{
                
                self.selectedWithoutSubmit(indexPath: IndexPath(row: row, section: i))
            }
        }
        
        // call delegate
        self.delegate?.cancelPopupView()
    }
}

// gesture recognizer
extension AZPopupPickerView: UIGestureRecognizerDelegate{
    
    // tap on input
    func inputPickerViewAction(gr:UITapGestureRecognizer){
        // check for load all data and then show
        if self.index.count == self.data.count {
            self.popup.show()
        }else{
            NSLog("AZPicker View data doesn't load ")
        }
    }
    
}
