//
//  AZScrollView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 3/23/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZScrollView: UIScrollView {

    // MARK: Public
    public var aZConstraints: AZConstraint!
    
    // MARK: Private
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: Init
    public override init(frame: CGRect) {
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
