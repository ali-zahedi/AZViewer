//
//  AZLabelIcon.swift
//  AZViewer
//
//  Created by Ali Zahedi on 2/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZLabelIcon: AZLabel {

    // MARK: IBInspectable
    @IBInspectable var leftIcon: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding: CGFloat = AZStyle.shared.sectionInputLeftPadding
    @IBInspectable var color: UIColor = AZStyle.shared.sectionInputIconColor {
        didSet {
            updateView()
        }
    }
    
    // MARK: Public
    
    
    // MARK: Private
    fileprivate var leftImageView: AZImageView = AZImageView()
    
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
    internal override func defaultInit(){
        super.defaultInit()
        
        // add view
        for v in [leftImageView] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // prepare left image 
        self.prepareLeftImageView()
    }
    
    // update view
    fileprivate func updateView() {
        self.leftImageView.image = self.leftIcon
        self.leftImageView.tintColor = self.color
    }
    
}

// prepare
extension AZLabelIcon{
    
    fileprivate func prepareLeftImageView(){
        self.leftImageView.contentMode = .scaleAspectFit
        _ = self.leftImageView.aZConstraints.parent(parent: self).centerY().left(constant: self.leftPadding).width(constant: 20).height(to: self.leftImageView, toAttribute: .width)
    }
}
