//
//  AZBaseView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

open class AZBaseView: UIView{
    
    // MARK: Public
    
    // MARK: Internal
    internal var aZConstraints: AZConstraint!
    internal var style: AZStyle {
        return AZStyle.shared
    }
    
    // MARK: Private
    
    // MARK: Override
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        self.aZConstraints = AZConstraint(view: self)
    }
}
