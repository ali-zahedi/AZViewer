//
//  AZPopupView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public enum AZPopupViewTypeFillMode {
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

public enum AZPopupViewAlignment {
    case top
    case center
    case bottom
    
    func alignment(constraint: AZConstraint) -> AZConstraint{
        switch self {
        case .top:
            return constraint.top()
        case .center:
            return constraint.centerY()
        case .bottom:
            return constraint.bottom()
            
        }
    }
}

public class AZPopupView: AZView{
    
    // MARK: Public
    public var title: String = "" {
        didSet{
            self.header.title = self.title
        }
    }
    public var header: AZHeader = AZHeader()
    public var view: AZBaseView = AZBaseView()
    public var fillMode: AZPopupViewTypeFillMode = .margin
    public var alignment: AZPopupViewAlignment = .bottom
    public var delegatePopupView: AZPopupViewDelegate?
    
    // MARK: Internal
    
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
        
        for v in [view, header] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.layer.cornerRadius = self.style.sectionPopupCornerRadius
        self.clipsToBounds = true
        self.backgroundColor = self.style.sectionPopupBackgroundColor
        
        // prepare header
        self.prepareHeader()
        
        // prepare view
        self.prepareView()
        
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
        _ = self.header.aZConstraints.parent(parent: self).top().right().left().height(constant: self.style.sectionHeaderHeight)
        self.header.delegate = self
    }
    
    // view
    fileprivate func prepareView(){
        _ = self.view.aZConstraints.parent(parent: self).top(to: self.header, toAttribute: .bottom).right().left()
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
        
        let constraint = self.aZConstraints.parent(parent: view).right(constant: -self.fillMode.widthMarginConstant()).left(constant: self.fillMode.widthMarginConstant())
            
        _ = self.alignment.alignment(constraint: constraint)
        
        _ = self.aZConstraints.bottom(to: self.view)
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
