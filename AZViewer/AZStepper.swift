//
//  AZStepper.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/11/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZStepper: UIView {
    
    // MARK: Public
    // plus icon
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
    
    // MARK: Private
    fileprivate var plusButton: UIButton = UIButton()
    fileprivate var minusButton: UIButton = UIButton()
    fileprivate var showNumberLabel: UILabel = UILabel()
    
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
        
        for v in [plusButton, minusButton, showNumberLabel] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // plus 
        NSLayoutConstraint(item: plusButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plusButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plusButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plusButton, attribute: .width, relatedBy: .equal, toItem: self.plusButton, attribute: .height, multiplier: 1, constant: 0).isActive = true
        self.plusIconColor = UIColor.black
        self.plusBackgroundColor = UIColor.white
        self.plusIcon = UIImage(named: "plus", in: AZView.bundle, compatibleWith: nil)
        
        // minus
        NSLayoutConstraint(item: minusButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minusButton, attribute: .width, relatedBy: .equal, toItem: self.minusButton, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        self.minusIconColor = UIColor.black
        self.minusBackgroundColor = UIColor.white
        self.minusIcon = UIImage(named: "minus", in: AZView.bundle, compatibleWith: nil)
        
        // input
        NSLayoutConstraint(item: showNumberLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: showNumberLabel, attribute: .right, relatedBy: .equal, toItem: self.minusButton, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: showNumberLabel, attribute: .left, relatedBy: .equal, toItem: self.plusButton, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: showNumberLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        self.showNumberLabel.backgroundColor = UIColor.white
        self.showNumberLabel.font = AZStyle.sectionInputFont
    }
}
