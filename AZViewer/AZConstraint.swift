//
//  AZConstraint.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/14/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZConstraint: NSObject {
    
    // MARK: Public
    public var parent: UIView?
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var left: NSLayoutConstraint?
    public var right: NSLayoutConstraint?
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
    
    // MARK: Internal
    
    // MARK: Private
    fileprivate var view: UIView!
    
    // MARK: Override
    public init(view: UIView) {
        super.init()
        self.view = view
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
    }
    
}

extension AZConstraint{
    
    public func parent(parent: UIView) -> AZConstraint{
        
        self.parent = parent
        return self
    }
}

// constraint
extension AZConstraint{
    
    // top
    public func top(to: UIView? = nil, toAttribute: NSLayoutAttribute = .top, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.top = constraint
        self.top?.isActive = active
        
        return self
        
    }
    
    // bottom
    public func bottom(to: UIView? = nil, toAttribute: NSLayoutAttribute = .bottom, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.bottom = constraint
        self.bottom?.isActive = active
        
        return self
        
    }
    
    
    // right
    public func right(to: UIView? = nil, toAttribute: NSLayoutAttribute = .right, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.right = constraint
        self.right?.isActive = active
        
        return self
        
    }
    
    // left
    public func left(to: UIView? = nil, toAttribute: NSLayoutAttribute = .left, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.left = constraint
        self.left?.isActive = active
        
        return self
        
    }
    
    // centerY
    public func centerY(to: UIView? = nil, toAttribute: NSLayoutAttribute = .centerY, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .centerY, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.centerY = constraint
        self.centerY?.isActive = active
        
        return self
        
    }
    
    // centerX
    public func centerX(to: UIView? = nil, toAttribute: NSLayoutAttribute = .centerX, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to ?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.centerX = constraint
        self.centerX?.isActive = active
        
        return self
        
    }
    
    // width
    public func width(to: UIView? = nil, toAttribute: NSLayoutAttribute = .width, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to //?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .width, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.width = constraint
        self.width?.isActive = active
        
        return self
        
    }
    
    // height
    public func height(to: UIView? = nil, toAttribute: NSLayoutAttribute = .height, multiplier: CGFloat = 1, constant: CGFloat = 0, active: Bool = true) -> AZConstraint{
        
        let toItem = to //?? self.parent
        
        let constraint = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        self.height = constraint
        self.height?.isActive = active
        
        return self
        
    }
}
