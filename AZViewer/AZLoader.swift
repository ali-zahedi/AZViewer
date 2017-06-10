//
//  AZLoader.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/20/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

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
    public var horizontalAlignment: AZHorizontalAlignment = .middle
    
    // background color, alpha, corner radius
    public var cornerRadius: CGFloat = AZStyle.shared.sectionLoaderCornerRadius
    public var blurIsHidden: Bool = false
    
    // MARK: Internal
    
    // MARK: Private
    fileprivate var parenView: UIView?
    fileprivate var view: AZBaseView!
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
        
        // prepare view
        self.prepareView()
        
        // at the end
        self.backgroundColor = self.style.sectionLoaderBlurBackgroundColor
        self.alpha = self.style.sectionLoaderBlurAlpha
        
    }
    
    public func parent(parent: UIView){
        self.parenView = parent
    }
}

// prepare
extension AZLoader{
    
    // view 
    fileprivate func prepareView(){
        self.view = AZBaseView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = self.backgroundColor
        self.view.alpha = self.alpha
        self.view.layer.cornerRadius = self.cornerRadius
        
        // prepare blur effect
        if self.blurIsHidden{
            self.view.backgroundColor = UIColor.clear
        }else{
            self.prepareBlurEffect()
        }
    }
    
    // blur effect
    fileprivate func prepareBlurEffect(){
        self.blurEffectView = UIVisualEffectView(effect: self.style.sectionLoaderBlurEffect)
        self.blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.blurEffectView.layer.cornerRadius = self.cornerRadius
        self.blurEffectView.clipsToBounds = true
        self.view.addSubview(self.blurEffectView)
        
        NSLayoutConstraint(item: self.blurEffectView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.blurEffectView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}

// animation
extension AZLoader{
    
    // start loader
    fileprivate func startLoader(){
        // released last blur for use shared
        self.prepareView()
        var viewAppend: UIView!
        var size: CGSize!
        
        // find parent
        if let v = self.parenView{
            viewAppend = v
        }else{
            // find master view
            guard let v: UIView = UIApplication.shared.keyWindow else{
                NSLog("AZLoader can't find key window")
                return
            }
            viewAppend = v
        }
        
        //
        viewAppend.addSubview(self.view)
        
        // find size 
        let minSize = min(viewAppend.bounds.width, viewAppend.bounds.height)
        
        if minSize > 50 || minSize == 0  {
            
            size = CGSize(width: 50, height: 50)
        }else{
            
            size = CGSize(width: minSize, height: minSize)
        }
        
        self.view.frame.size = size
        
        // NSLayout
        
        NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: viewAppend, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view, attribute: self.horizontalAlignment.attribute(), relatedBy: .equal, toItem: viewAppend, attribute: self.horizontalAlignment.attribute(), multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height).isActive = true
        NSLayoutConstraint(item: self.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width).isActive = true

        
        self.setUpAnimation(in: self.view.layer, size: size)
    }
    
    // end loader
    fileprivate func endLoader(){
        self.view.removeFromSuperview()
        self.removeAnimation(sender: self.view)
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
