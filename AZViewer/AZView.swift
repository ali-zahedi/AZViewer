//
//  AZView.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

open class AZView: UIView {
    
    // public
    
    // internal 
    internal static let bundle = Bundle(for: AZView.self)
    internal var headerSection: AZHeaderSection!
    
    // private

    
    // override
    override public init(frame: CGRect){
        
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){
        AZStyle.loadTheme()
        self.prepareThisView()
    }
    
    
}

// feature
extension AZView {
    
    // add header section
    internal func prepareHeaderSection(title: String = ""){
        
        self.headerSection = AZHeaderSection()
        
        self.headerSection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerSection)
        
        // header section
        NSLayoutConstraint(item: self.headerSection, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.headerSection, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.headerSection, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.headerSection, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: AZStyle.sectionHeaderHeight).isActive = true
        
        self.headerSection.titleLabel.text = title
        self.headerSection.delegate = self
    }
    
}

// prepare section
extension AZView{
    
    fileprivate func prepareThisView(){
        self.backgroundColor = AZStyle.sectionViewBackgroundColor
//        self.frame.size = CGSize(width: 300, height: 600)
//        self.frame.origin = CGPoint(x: 50, y: 10)
//        self.layer.cornerRadius = 30
//        self.backgroundColor = UIColor.black
    }
}

// add color hex feature
extension AZView{
    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension AZView: AZViewDelegate{
    
    func closeView() {
        
        
    }
}
