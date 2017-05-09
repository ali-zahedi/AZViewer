//
//  AZNotifications.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/26/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public enum AZNotificationType {
    
    case information
    case success
    case warning
    case error
    case unknown
    
    func color() -> (UIColor, UIColor) {
        switch self {
        case .information:
            return (AZStyle.shared.sectionNotificationTypeInformationBackgroundColor, AZStyle.shared.sectionNotificationTypeInformationColor)
        case .success:
            return (AZStyle.shared.sectionNotificationTypeSuccessBackgroundColor, AZStyle.shared.sectionNotificationTypeSuccessColor)
        case .warning:
            return (AZStyle.shared.sectionNotificationTypeWarningBackgroundColor, AZStyle.shared.sectionNotificationTypeWarningColor)
        case .error:
            return (AZStyle.shared.sectionNotificationTypeErrorBackgroundColor, AZStyle.shared.sectionNotificationTypeErrorColor)
        case .unknown:
            return (UIColor.clear, UIColor.clear)
        }
    }
}

public class AZNotification{
    
    // MARK: Public
    public static let shared = AZNotification()
    
    // view
    public var backgroundColor: UIColor! {
        didSet{
            self.view.backgroundColor = self.backgroundColor
        }
    }
    public var color: UIColor! {
        didSet{
            self.content.textColor = self.color
        }
    }
    // TODO: work on alignment show
    public var horizontalAlignment: AZHorizontalAlignment!
    public var verticalAlignment: AZVerticalAlignment!
    public var font: UIFont! {
        didSet{
            self.content.font = self.font
        }
    }
    public var cornerRadius: CGFloat!{
        didSet{
            self.view.layer.cornerRadius = self.cornerRadius
        }
    }
    // close button
    public var leftButtonImage: UIImage! {
        didSet{
            self.leftButton.setImage(self.leftButtonImage, for: .normal)
        }
    }
    public var leftButtonTintColor: UIColor! {
        didSet{
            self.leftButton.tintColor = self.leftButtonTintColor
        }
    }
    
    // MARK: Internal
    
    
    // MARK: Private
    fileprivate var style = AZStyle.shared
    fileprivate var view: AZView!
    fileprivate var content: AZLabel!
    fileprivate var leftButton: AZButton!
    
    // MARK: Init
    //This prevents others from using the default '()' initializer for this class.
    private init() {
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
        self.view = AZView()
        self.content = AZLabel()
        self.leftButton = AZButton()
        
        for v in [content, leftButton] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(v)
        }
        
        // view
        self.prepareView()
        
        // content
        self.prepareContent()
        
        // left button
        self.prepareLeftButton()
    }
    
    // close button action
    @objc func leftButtonAction(_ sender: UIView){
        var view: UIView = sender
        
        if sender is AZButton{
            let btn = sender as! AZButton
            if let v = btn.superview{
                view = v
            }
        }
        
        self.remove(view: view)
    }
    
    // close button action
    @objc func tapViewAction(_ sender: UIGestureRecognizer){
        self.leftButtonAction(self.view)
    }
}

// MARK: Prepare
extension AZNotification{
    
    // view
    fileprivate func prepareView(){
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.clipsToBounds = true
        self.view.isUserInteractionEnabled = true
        
        self.cornerRadius = self.style.sectionNotificationCornerRadius
        self.backgroundColor = self.style.sectionNotificationBackgroundColor
        self.horizontalAlignment = .middle
        self.verticalAlignment = .middle
    }
    
    // content
    fileprivate func prepareContent(){
        _ = self.content.aZConstraints.parent(parent: self.view).top(constant: 8).right(constant: -16).left(constant: 32)
        self.content.textAlignment = .center
        self.content.lineBreakMode = .byWordWrapping
        self.content.numberOfLines = 0
        self.font = self.style.sectionNotificationFont
        self.color = self.style.sectionNotificationColor
        self.content.isUserInteractionEnabled = true
    }
    
    // left button
    fileprivate func prepareLeftButton(){
        _ = self.leftButton.aZConstraints.parent(parent: self.view).top(to: self.content, toAttribute: .centerY, constant: -12).left(constant: 8).width(constant: 16).height(to: self.leftButton, toAttribute: .width)
        self.leftButtonImage = AZAssets.closeImage
        self.leftButtonTintColor = self.style.sectionNotificationTintButtonColor
        self.leftButton.addTarget(self, action: #selector(leftButtonAction(_:)), for: .touchUpInside)
    }
}

// MARK: show
extension AZNotification{
    
    // public show
    public func show(msg: String, type: AZNotificationType? = nil, hideAfterSeconds: Double = 0, hideOnTap: Bool = false){
        
        self.view.removeFromSuperview()
        self.defaultInit()
        let type = type ?? .unknown
        var backgroundColor: UIColor = self.backgroundColor
        var color: UIColor = self.color
        
        if type != .unknown{
            
            (backgroundColor, color) = type.color()
        }
        
        self.view.backgroundColor = backgroundColor
        self.content.textColor = color
        self.content.text = msg
        
        self.show()
        
        if hideAfterSeconds > 0.5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + hideAfterSeconds) {
                self.remove()
            }
        }
        
        if hideOnTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewAction(_:)))
            self.content.addGestureRecognizer(tapGesture)
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    // show notification
    fileprivate func show(){
        
        guard let rootView: UIView = UIApplication.shared.keyWindow else{
            NSLog("AZLoader can't find key window")
            return
        }
        
        rootView.addSubview(self.view)
        _ = self.view.aZConstraints.parent(parent: rootView).top(constant: 20).right(constant: -8).left(constant: 8)
        
        self.view.layoutIfNeeded()
        _ = self.view.aZConstraints.bottom(to: self.content, constant: 0)
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 1.2, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: [], animations: {
            
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
    }
    
    // remove
    public func remove(view: UIView? = nil){
        
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: 300, y: -100)
        transform = transform.rotated(by: 360)
        
        let viewRemove = view ?? self.view
        
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: [], animations: {
            
            viewRemove?.transform = transform
            
            }, completion: {(result) in
                viewRemove?.removeFromSuperview()})
        
        
    }
}
