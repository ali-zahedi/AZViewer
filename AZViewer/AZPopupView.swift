//
//  AZPopupView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

enum AZPopupViewTypeFillMode {
    case fill
    case margin
    
    func widthMarginConstant() -> CGFloat{
        let width: CGFloat = UIScreen.main.bounds.width
        switch self {
        case .fill:
            return 0
        case .margin:
            return width * AZStyle.shared.sectionPopupMarginMultiplier
        }
    }
}

public class AZPopupView: AZView{
    
    // MARK: Public
    public var title: String = "" {
        didSet{
            self.headerSection.title = self.title
        }
    }
    
    // MARK: Internal
    internal var fillMode: AZPopupViewTypeFillMode = .margin
    internal var delegatePopupView: AZPopupViewDelegate?
    internal var headerSection: AZHeader = AZHeader()
    
    // MARK: Private
    fileprivate var blurEffectView: UIVisualEffectView!
    
    
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
        
        for v in [headerSection] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.layer.cornerRadius = self.style.sectionPopupCornerRadius
        self.clipsToBounds = true
        self.backgroundColor = self.style.sectionPopupBackgroundColor
        
        // prepare header
        self.prepareHeader()
        
        // prepare blur effect
        self.prepareBlurEffect()
    }
    
    public func show(){
        guard let view: UIView = UIApplication.shared.keyWindow else{
            return
        }
        
        self.blurEffectView.frame = view.bounds
        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.showViewAnimation(view: view)
    }
    
    // cancel
    func cancelPopup(_ sender: AnyObject){
        self.delegatePopupView?.cancelPopupView()
        self.closeViewAnimation()
    }
    
    // submit
    func submitPopup(_ sender: AnyObject){
        self.delegatePopupView?.submitPopupView()
        self.closeViewAnimation()
    }
}

// prepare
extension AZPopupView{
    
    // header
    fileprivate func prepareHeader(){
        _ = self.headerSection.aZConstraints.parent(parent: self).top().right().left().height(constant: self.style.sectionHeaderHeight)
        self.headerSection.delegate = self
    }
    
    // blur effect
    fileprivate func prepareBlurEffect(){
        self.blurEffectView = UIVisualEffectView(effect: self.style.sectionPopupBlurEffect)
        self.blurEffectView.alpha = self.style.sectionPopupBlurAlpha
        
        // add gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelPopup(_:)))
        self.blurEffectView.addGestureRecognizer(tap)
    }
}

// animation
extension AZPopupView{
    
    // close
    fileprivate func closeViewAnimation(){
        
        self.blurEffectView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    // show
    fileprivate func showViewAnimation(view: UIView){
        
        view.addSubview(blurEffectView)
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        _ = self.aZConstraints.parent(parent: view).bottom().right(constant: -self.fillMode.widthMarginConstant()).left(constant: self.fillMode.widthMarginConstant())
    }
}

// delegate header
extension AZPopupView: AZPopupViewDelegate{
    public func cancelPopupView() {
        
        self.cancelPopup(self)
    }
    
    public func submitPopupView() {
        self.submitPopup(self)
    }
}
