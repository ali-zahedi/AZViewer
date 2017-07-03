//
//  AZTextField.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/16/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZTextField: UITextField {
    
    // MARK: IBInspectable
    @IBInspectable var leftIcon: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding: CGFloat = AZStyle.shared.sectionInputLeftPadding
    @IBInspectable var color: UIColor = AZStyle.shared.sectionInputIconColor {
        didSet {
            updateView()
        }
    }
    
    // MARK: Public
    public var aZConstraints: AZConstraint!
    
    // MARK: var
    
    // MARK: Internal
    
    // MARK: Private
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // MARK: Init
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
        self.aZConstraints = AZConstraint(view: self)
        
        for _ in [] as [UIView]{
            
        }
        
        self.addDoneButtonOnKeyboard()
    }
    
    
    // Provides left padding for images
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    // MARK: Function
    fileprivate func updateView() {
        if let image = leftIcon {
            leftViewMode = UITextFieldViewMode.always
            let imageView = AZImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
    }
    
    fileprivate func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "تایید", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        done.setTitleTextAttributes([NSFontAttributeName: AZStyle.shared.sectionInputFont], for: .normal)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    public func doneButtonAction(){
        
        self.resignFirstResponder()
    }
    
}
