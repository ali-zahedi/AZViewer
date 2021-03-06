//
//  AZStepper.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/11/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZStepper: AZView {
    
    // MARK: Public
    public var delegate: AZStepperDelegate?
    
    // input
    public var minValue: Int = 1
    public var maxValue: Int = Int.max
    public var value: Int {
        set{
            if self.minValue <= newValue && self.maxValue > newValue {
                
                self._value = newValue
            }
        }get{
            
            return self._value
        }
    }
    // plus
    public var plusIcon: UIImage!{
        didSet{
            self.plusButton.setImage(self.plusIcon, for: .normal)
        }
    }
    
    public var plusBackgroundColor: UIColor! {
        didSet{
            self.plusButton.backgroundColor = self.plusBackgroundColor
        }
    }
    
    public var plusIconColor: UIColor!{
        didSet{
            self.plusButton.tintColor = self.plusIconColor
        }
    }
    
    // minus
    public var minusIcon: UIImage!{
        didSet{
            self.minusButton.setImage(self.minusIcon, for: .normal)
        }
    }
    
    public var minusBackgroundColor: UIColor! {
        didSet{
            self.minusButton.backgroundColor = self.minusBackgroundColor
        }
    }
    
    public var minusIconColor: UIColor!{
        didSet{
            self.minusButton.tintColor = self.minusIconColor
        }
    }
    
    // input 
    public var inputBackgroundColor: UIColor! {
        didSet{
            self.showNumberLabel.backgroundColor = self.inputBackgroundColor
        }
    }
    public var inputTextColor: UIColor!{
        didSet{
            self.showNumberLabel.textColor = self.inputTextColor
        }
    }
    public var inputTextFont: UIFont! {
        didSet{
            self.showNumberLabel.font = self.inputTextFont
        }
    }
    
    // MARK: Private
    fileprivate var plusButton: AZButton = AZButton()
    fileprivate var minusButton: AZButton = AZButton()
    fileprivate var showNumberLabel: AZLabel = AZLabel()
    fileprivate var _value: Int! {
        didSet{
            self.showNumberLabel.text = self.value.description
        }
    }
    
    // MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.defaulInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaulInit()
    }
    
    // MARK: Function
    fileprivate func defaulInit(){
        
        self._value = self.minValue
        self.layer.cornerRadius = self.style.sectionStepperCornerRadius
        self.clipsToBounds = true
        
        for v in [plusButton, minusButton, showNumberLabel] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // plus 
        self.preparePlusButton()
        
        // minus
        self.prepareMinusButton()
        
        // input
        self.prepareInputLabel()

    }
    
    func tapPlusButton(_ sender: AZButton){
        
        self.value += 1
        self.delegate?.aZStepper(changeValue: self.value)
    }
    
    func tapMinusButton(_ sender: AZButton){
        self.value -= 1
        self.delegate?.aZStepper(changeValue: self.value)
    }
}

// prepare
extension AZStepper{
    
    // plus
    fileprivate func preparePlusButton(){
        _ = self.plusButton.aZConstraints.parent(parent: self).top().right().height(to: self).width(to: self.plusButton, toAttribute: .height)
        self.plusIconColor = self.style.sectionStepperPlusIconColor
        self.plusBackgroundColor = self.style.sectionStepperPlusBackgroundColor
        self.plusIcon = AZAssets.plusImage
        self.plusButton.addTarget(self, action: #selector(tapPlusButton(_:)), for: .touchUpInside)
    }
    
    // minus
    fileprivate func prepareMinusButton(){
        _ = self.minusButton.aZConstraints.parent(parent: self).top().left().height(to: self).width(to: self.minusButton, toAttribute: .height)
        
        self.minusIconColor = self.style.sectionStepperMinusIconColor
        self.minusBackgroundColor = self.style.sectionStepperMinusBackgroundColor
        self.minusIcon = AZAssets.minusImage
        self.minusButton.addTarget(self, action: #selector(tapMinusButton(_:)), for: .touchUpInside)
    }
    
    // input
    fileprivate func prepareInputLabel(){
        _ = self.showNumberLabel.aZConstraints.parent(parent: self).top().right(to: self.plusButton, toAttribute: .left).left(to: self.minusButton, toAttribute: .right).height(to: self)
        
        self.inputTextColor =  self.style.sectionStepperInputTextColor
        self.inputBackgroundColor = self.style.sectionStepperInputBackgroundColor
        self.inputTextFont = self.style.sectionStepperInputFont
        self.showNumberLabel.textAlignment = .center
    }
    
}
