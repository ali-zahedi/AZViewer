//
//  AZLoader.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/20/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public enum AZLoaderHorizontalAlignment {
    case right
    case middle
    case left
    
    func attribute() -> NSLayoutAttribute{
        switch self {
        case .right:
            return .right
        case .left:
            return .left
        case .middle:
            return .centerX
        }
    }
}

public class AZLoader: AZBaseView{
    
    // MARK: Public
    public static let shared = AZLoader()
    public var isActive: Bool {
        set{
            if newValue != self._isActive {
                self._isActive = newValue
            }
        }get{
            return self._isActive
        }
    }
    
    public var color: UIColor = AZStyle.shared.sectionLoaderColor
    public var horizontalAlignment: AZLoaderHorizontalAlignment = .middle
    // MARK: Internal
    
    // MARK: Private
    fileprivate var parenView: UIView?
    fileprivate var blurEffectView: UIVisualEffectView!
    fileprivate var _isActive: Bool = false {
        didSet{
            if self._isActive {
                self.startLoader()
            }else{
                self.endLoader()
            }
        }
    }
    // MARK: Override
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
        
        for v in [] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // prepare blur effect
        self.prepareBlurEffect()
    }
    
    public func parent(parent: UIView){
        self.parenView = parent
    }
}

// prepare
extension AZLoader{
    
    // blur effect
    fileprivate func prepareBlurEffect(){
        self.blurEffectView = UIVisualEffectView(effect: self.style.sectionPopupBlurEffect)
        self.blurEffectView.alpha = self.style.sectionPopupBlurAlpha
        self.blurEffectView.layer.cornerRadius = AZStyle.shared.sectionGeneralCornerRadius
        self.blurEffectView.clipsToBounds = true
    }
    
}

// animation
extension AZLoader{
    
    // start loader
    fileprivate func startLoader(){
        var view: UIView!
        var size: CGSize!
        
        // find parent
        if let v = self.parenView{
            view = v
        }else{
            // find master view
            guard let v: UIView = UIApplication.shared.keyWindow else{
                NSLog("AZLoader can't find key window")
                return
            }
            view = v
        }
        
        // 
        self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        
        // find size 
        let minSize = min(view.bounds.width, view.bounds.height)
        
        if minSize > 50 {
            size = CGSize(width: 50, height: 50)
        }else{
            size = CGSize(width: minSize, height: minSize)
        }
        
        // NSLayout
        NSLayoutConstraint(item: self.blurEffectView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: self.horizontalAlignment.attribute(), relatedBy: .equal, toItem: view, attribute: self.horizontalAlignment.attribute(), multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width).isActive = true

        
        self.blurEffectView.frame.size = size
        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.setUpAnimation(in: self.blurEffectView.layer, size: size)
    }
    
    // end loader
    fileprivate func endLoader(){
        self.blurEffectView.removeFromSuperview()
        self.removeAnimation(sender: self.blurEffectView)
    }
    
    // remove loader animation
    fileprivate func removeAnimation(sender: UIView){
        sender.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
    
    // add loader animation
    func setUpAnimation(in layer: CALayer, size: CGSize) {
        let bigCircleSize: CGFloat = size.width
        let smallCircleSize: CGFloat = size.width / 2
        let longDuration: CFTimeInterval = 1
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        circleOf(shape: .ringTwoHalfHorizontal,
                 duration: longDuration,
                 timingFunction: timingFunction,
                 layer: layer,
                 size: bigCircleSize,
                 color: color, reverse: false)
        circleOf(shape: .ringTwoHalfVertical,
                 duration: longDuration,
                 timingFunction: timingFunction,
                 layer: layer,
                 size: smallCircleSize,
                 color: color, reverse: true)
    }
    
    // create animation for each circle
    func createAnimationIn(duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, reverse: Bool) -> CAAnimation {
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.timingFunctions = [timingFunction, timingFunction]
        scaleAnimation.values = [1, 0.6, 1]
        scaleAnimation.duration = duration
        
        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        
        rotateAnimation.keyTimes = scaleAnimation.keyTimes
        rotateAnimation.timingFunctions = [timingFunction, timingFunction]
        if !reverse {
            rotateAnimation.values = [0, M_PI, 2 * M_PI]
        } else {
            rotateAnimation.values = [0, -M_PI, -2 * M_PI]
        }
        rotateAnimation.duration = duration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, rotateAnimation]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    // create animation
    func circleOf(shape: AZIndicatorShape, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGFloat, color: UIColor, reverse: Bool) {
        let circle = shape.layerWith(size: CGSize(width: size, height: size), color: color)
        let frame = CGRect(x: (layer.bounds.size.width - size) / 2,
                           y: (layer.bounds.size.height - size) / 2,
                           width: size,
                           height: size)
        let animation = createAnimationIn(duration: duration, timingFunction: timingFunction, reverse: reverse)
        
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
