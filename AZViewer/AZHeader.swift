//
//  AZHeader.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

enum AZHeaderType {
    case title
    case success
}

class AZHeader: AZBaseView{
    
    // MARK: Public
    public var title: String = ""{
        didSet{
            self.titleLabel.text = self.title
        }
    }
    
    public var type: AZHeaderType! {
        didSet{
            
            let hiddenTitle: Bool = self.type == .success ? true : false
            
            self.successButton.isHidden = !hiddenTitle
            self.titleLabel.isHidden = hiddenTitle
        }
    }
    
    // MARK: Internal
    internal var delegate: AZPopupViewDelegate?
    
    // MARK: Private
    fileprivate var titleLabel: AZLabel = AZLabel()
    fileprivate var closeButton: AZButton = AZButton()
    fileprivate var successButton: AZButton = AZButton()
    
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
        
        for v in [titleLabel, closeButton, successButton] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // title
        self.prepareTitle()
        
        // close button
        self.prepareCloseButton()
        
        // success button
        self.prepareSuccessButton()
        
        // init 
        self.type = .title
        
    }
    
    // cancell action
    func cancelButtonAction(_ sender: AZButton){
        
        self.delegate?.cancelPopupView()
    }
    
    // success action
    func successButtonAction(_ sender: AZButton){
        
        self.delegate?.submitPopupView()
    }
}


// prepare
extension AZHeader{
    
    // title
    fileprivate func prepareTitle(){
        _ = self.titleLabel.aZConstraints.parent(parent: self).top().right(constant: -self.style.sectionGeneralConstant).left(multiplier: 0.7).bottom()
        self.titleLabel.textColor = self.style.sectionHeaderTitleColor
        self.titleLabel.font = self.style.sectionHeaderTitleFont
    }
    
    // close
    fileprivate func prepareCloseButton(){
        let height = self.style.sectionHeaderHeight / 4
        _ = self.closeButton.aZConstraints.parent(parent: self).top(constant: height).bottom(constant: -height).left(constant: self.style.sectionGeneralConstant).width(constant: height * 2)
        self.closeButton.setImage(AZAssets.closeImage, for: .normal)
        
        self.closeButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
    }
    
    // success
    fileprivate func prepareSuccessButton(){
        
        let height = self.style.sectionHeaderHeight / 4
        _ = self.successButton.aZConstraints.parent(parent: self).top(constant: height).bottom(constant: -height).right(constant: -self.style.sectionGeneralConstant).width(constant: height * 2)
        self.successButton.setImage(AZAssets.tickImage, for: .normal)
        
        self.successButton.addTarget(self, action: #selector(successButtonAction(_:)), for: .touchUpInside)
        
    }
}
