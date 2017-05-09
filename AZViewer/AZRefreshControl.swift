//
//  AZRefreshControl.swift
//  AZViewer
//
//  Created by Ali Zahedi on 2/19/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZRefreshControl: UIRefreshControl{
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    // MARK: Public
    public var loader: AZLoader = AZLoader()
    
    // MARK: Private
    
    // MARK: Init
    override public init() {
        super.init()
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        self.loader.parent(parent: self)
        self.loader.blurIsHidden = true
        self.loader.horizontalAlignment = .middle
        self.tintColor = UIColor.clear
    }
    
}
