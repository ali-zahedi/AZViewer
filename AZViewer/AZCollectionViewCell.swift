//
//  AZCollectionViewCell.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/22/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import UIKit

public class AZCollectionViewCell: UICollectionViewCell {
    
    // MARK: Public
    public var aZConstraints: AZConstraint!
    
    // MARK: Private
    
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
