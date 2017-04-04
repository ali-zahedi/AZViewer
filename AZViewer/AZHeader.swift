//
//  AZHeader.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

enum AZHeaderType {
    case success
}

class AZHeader: AZBaseView{
    
    // MARK: Public
    public var title: String = ""{
        didSet{
            self.titleLabel.text = self.title
        }
    }
    
    public var type: AZHeaderType = .success {
        didSet{
            
        }
    }
    
    // MARK: Internal
    internal var delegate: AZPopupViewDelegate?
    
    // MARK: Private
    fileprivate var titleLabel: AZLabel = AZLabel()
    fileprivate var closeButton: AZButton = AZButton()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        self.backgroundColor = self.style.sectionHeaderBackgroundColor
        
        for v in [titleLabel, closeButton] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // title
        self.prepareTitle()
        
        // close button
        self.prepareCloseButton()
        
    }
    
    func cancelButtonAction(_ sender: AZButton){
        self.delegate?.cancelPopupView()
    }
}


// prepare
extension AZHeader{
    
    // title
    fileprivate func prepareTitle(){
        _ = self.titleLabel.aZConstraints.top(to: self).right(to: self, constant: -self.style.sectionGeneralConstant).left(to: self, multiplier: 0.7).bottom(to: self)
        self.titleLabel.textColor = self.style.sectionHeaderTitleColor
        self.titleLabel.font = self.style.sectionHeaderTitleFont
    }
    
    // close
    fileprivate func prepareCloseButton(){
        let height = self.style.sectionHeaderHeight / 4
        _ = self.closeButton.aZConstraints.top(to: self, constant: height).bottom(to: self, constant: -height).left(to: self, constant: self.style.sectionGeneralConstant).width(constant: height * 2)
        self.closeButton.setImage(AZAssets.closeImage, for: .normal)
        
        self.closeButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
    }
}
