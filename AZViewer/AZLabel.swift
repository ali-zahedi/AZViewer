//
//  AZLabel.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZLabel: UILabel {
    
    // MARK: Public
    public var aZConstraints: AZConstraint!
    public var loader: AZLoader = AZLoader()
    // MARK: Internal
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
        super.draw(rect)
     }
    *//*
    override public func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 0.0, right: 0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        
    }
    */
    // MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    internal func defaultInit(){
        self.loader.parent(parent: self)
        self.aZConstraints = AZConstraint(view: self)
        self.textAlignment = .right
    }
    
    public func height(widht: CGFloat? = nil) -> CGFloat{
        
        let w: CGFloat = widht ?? self.frame.width
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height + (label.frame.height * 0.3)
    }
}
