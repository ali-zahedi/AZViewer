//
//  AZStyle.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

class AZStyle{
    
    fileprivate struct Style {
        static let shared = AZStyle()
    }
    
    // MARK: Public
    static let shared = AZStyle()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    
    // MARK: General
    var sectionGeneralHeight: CGFloat = CGFloat(30)
    var sectionGeneralConstant: CGFloat = CGFloat(8)
    
    // MARK: Section Headers
    var sectionHeaderHeight: CGFloat {
        return sectionGeneralHeight
    }
    var sectionHeaderTitleFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote).pointSize)!
    var sectionHeaderTitleColor = UIColor.white
    var sectionHeaderBackgroundColor = UIColor(hex: "FF5E3A")
    var sectionHeaderAlpha: CGFloat = 1.0
    
    // MARK: Section Table
    
    // MARK: Section View
    var sectionViewBackgroundColor: UIColor = UIColor(hex: "f8f7f4")
    var sectionViewSeperatorColor: UIColor = UIColor(hex: "e8e6e1")
    
    // MARK: Section Popup
    var sectionPopupBlurAlpha: CGFloat = CGFloat(0.75)
    var sectionPopupBlurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    var sectionPopupCornerRadius: CGFloat = CGFloat(5)
    var sectionPopupMarginMultiplier: CGFloat = CGFloat(0.10)
    var sectionPopupBackgroundColor: UIColor = UIColor.white
    
    // MARK: Section Input
    var sectionInputFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    
    // MARK: Section Picker View
    var sectionPickerViewItemFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    var sectionPickerViewItemColor: UIColor = UIColor.black
    
    let availableThemes = ["apple", "lightGray"]
    
    func loadTheme(){
        
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "AZTheme"){
            // Select the Theme
            switch name {
            case "lightGray":
                themeLightGray()
            default:
                themeMaster()
            }
        }else{
            defaults.set("apple", forKey: "AZTheme")
            themeMaster()
        }
    }
    
    // MARK: Blue Color Schemes
    func themeMaster(){
        // MARK: TODO Table Section Headers
        
    }
    
    // MARK: Light Gray Color Schemes
    func themeLightGray(){
        
    }
}
