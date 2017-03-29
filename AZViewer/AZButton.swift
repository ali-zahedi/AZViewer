//
//  AZButton.swift
//  Pods
//
//  Created by Ali Zahedi on 12/27/1395 AP.
//
//

import Foundation

open class AZButton: UIButton{
    
    public var loader: Bool = false
    
    fileprivate var loaderMask: UIView = UIView()
    
    override open var frame: CGRect {
        didSet{
            super.frame = frame
            self.layer.cornerRadius = self.frame.height / 2
            
            self.resetFrameLoaderMask()
        }
    }
    
    override open var backgroundColor: UIColor?{
        didSet{
            super.backgroundColor = backgroundColor
            self.loaderMask.backgroundColor = self.backgroundColor
        }
    }
    
    override public init(frame: CGRect){
        
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){
        
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
    }
}

extension AZButton {
    
    // small and loader animation
    func tapButton(){
        
        if self.loader && self.frame.size == self.loaderMask.frame.size{
            
            self.addAnimationLoader()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                
                self.removeAnimationButton(sender: self.loaderMask)
                self.removeAnimationLoader()
            }
            
        }
    }
    
    fileprivate func resetFrameLoaderMask(){
        
        self.loaderMask.frame = self.frame
        self.loaderMask.layer.cornerRadius = self.frame.height / 2
    }
}

// animation
extension AZButton{
    
    // animation for show and hidding loader
    fileprivate func addAnimationLoader(){
        
        self.superview?.addSubview(self.loaderMask)
        self.removeFromSuperview()
        
        let width: CGFloat = self.frame.height
        let center: CGFloat = self.center.x
        
        let minus = CGFloat(15)
        let size = CGSize(width: width - minus , height: self.frame.size.height - minus )
        
        self.animationLoader(width: width, center: center)
        
        self.setUpAnimation(in: self.loaderMask.layer, size: size, color: UIColor.white)
        
    }
    
    fileprivate func removeAnimationLoader(){
        
        let width: CGFloat = self.frame.width
        let center: CGFloat = self.center.x

        self.frame = self.loaderMask.frame
        self.loaderMask.superview?.addSubview(self)
        self.loaderMask.removeFromSuperview()
        
        // todo: get animation loader view and then process on the view
        self.animationLoader(width: width, center: center, view: self)
        self.resetFrameLoaderMask()
    }
    
    fileprivate func animationLoader(width: CGFloat, center: CGFloat, view: UIView? = nil){
        var v = view
        
        if v == nil {
            v = self.loaderMask
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            
            v?.frame.size.width = width
            v?.center.x = center
            
            }, completion: nil)
    }
    // remove loader animation
    fileprivate func removeAnimationButton(sender: UIView){
        sender.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
    
    // add loader animation
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
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
