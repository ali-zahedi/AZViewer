//
//  AZSegmentControl.swift
//  AZViewer
//
//  Created by Ali Zahedi on 3/23/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZSegmentControl: UISegmentedControl {
    
    // MARK: Public
    public var aZConstraints: AZConstraint!
    public var font: UIFont = AZStyle.shared.sectionSegmentControlFont {
        didSet{
            self.updateFont()
        }
    }
    public var titleColor: UIColor = AZStyle.shared.sectionSegmentContrlTitleColor{
        didSet{
            self.updateFont()
        }
    }
    // MARK: Private
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    public override init(items: [Any]?) {
        super.init(items: items)
        self.defaultInit()
        if let v = items, v.count > 0 {
            self.selectedSegmentIndex = v.count - 1
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        self.aZConstraints = AZConstraint(view: self)
        self.tintColor = AZStyle.shared.sectionSegmentContrlTintColor
        self.updateFont()
    }
    
    // update font
    fileprivate func updateFont(){
        let attr: [NSObject : AnyObject] = [
            NSForegroundColorAttributeName as NSObject: self.titleColor,
            NSFontAttributeName as NSObject: self.font
        ]
        
        self.setTitleTextAttributes(attr, for: .normal)
        
    }
}
