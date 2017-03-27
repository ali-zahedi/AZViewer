//
//  AZHeaderSection.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/7/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

class AZHeaderSection: UIView {
    
    // public
    var delegate: AZViewDelegate?
    var titleLabel: AZLabel = AZLabel()
    var closeButton: AZButton = AZButton()
    var separatorView: UIView = UIView()
    
    var height: CGFloat {
        get{
            return AZStyle.sectionHeaderHeight
        }
    }
    
    // internal
    
    // private
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){

        for v in [self.titleLabel, self.closeButton, self.separatorView] as [UIView] {
            
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.prepareTitle()
        self.prepareCloseButton()
        self.prepareSeparatorView()
    }
    
    // close button
    fileprivate func prepareCloseButton(){
        
        let percent = CGFloat(0.70)
        self.closeButton.setImage(UIImage(named: "close", in: AZView.bundle, compatibleWith: nil), for: .normal)
        self.closeButton.addTarget(self, action:#selector(closeButtonAction), for: .touchUpInside)
        NSLayoutConstraint(item: self.closeButton, attribute: .right, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.closeButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.height * percent).isActive = true
        NSLayoutConstraint(item: self.closeButton, attribute: .width, relatedBy: .equal, toItem: self.closeButton, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        self.closeButton.layer.cornerRadius = (self.height * percent) / 2
        self.closeButton.imageView?.contentMode = .scaleAspectFill
    }
    
    // title
    fileprivate func prepareTitle(){
        
        self.titleLabel.textAlignment = .right
        self.titleLabel.verticalAlignment = .middle
        self.titleLabel.font = AZStyle.sectionHeaderTitleFont
        self.titleLabel.textColor = AZStyle.sectionHeaderTitleColor
        NSLayoutConstraint(item: self.titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    // separatorView
    fileprivate func prepareSeparatorView(){
        self.separatorView.backgroundColor = AZStyle.sectionViewSeperatorColor
        
        
        NSLayoutConstraint(item: self.separatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.separatorView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.separatorView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.separatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 3).isActive = true
        
    }
    
    
}

extension AZHeaderSection{
    
    func closeButtonAction(sender: AZButton){
        
        self.delegate?.closeView()
    }
    
}
