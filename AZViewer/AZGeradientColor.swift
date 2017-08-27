//
//  AZGeradientColor.swift
//  AZViewer
//
//  Created by Saeed Rajabalizadeh on 8/27/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation

public class AZGradientLayer: CAGradientLayer{
    
    // Mark: Public
    
    // Mark: Private
    
    // Mark: Init
    
    override public init() {
        super.init()
        self.defaultInit()
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    public init(colorTop: UIColor, colorBottom: UIColor) {
        super.init()
        self.defaultInit()
        self.colors = [colorTop.cgColor, colorBottom.cgColor]
        self.locations = [0.0, 1.0]
    }
    
    // Mark: function
    fileprivate func defaultInit(){
        
    }
}
