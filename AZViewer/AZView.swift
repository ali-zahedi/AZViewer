//
//  AZView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

open class AZView: AZBaseView{
    
    // MARK: Public
    public var loader: AZLoader = AZLoader()
    
    // MARK: Internal
    
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
        
        self.loader.parent(parent: self)
        for v in [] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
    }
}

// prepare
extension AZView{
    
    
}
