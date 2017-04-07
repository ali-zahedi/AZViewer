//
//  AZImageView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/16/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZImageView: UIImageView {
    
    // MARK: Public
    
    // MARK: var
    
    // MARK: Internal
    internal var aZConstraints: AZConstraint!
    
    // MARK: Private
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // MARK: Init
    override public init(image: UIImage?) {
        super.init(image: image)
        self.defaultInit()
    }
    
    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.defaultInit()
    }
    
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
