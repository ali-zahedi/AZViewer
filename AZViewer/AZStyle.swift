//
//  AZStyle.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZStyle{
    
    fileprivate struct Style {
        static let shared = AZStyle()
    }
    
    // MARK: Public
    public static let shared = AZStyle()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    
    // MARK: General
    public var sectionGeneralHeight: CGFloat = CGFloat(30)
    public var sectionGeneralConstant: CGFloat = CGFloat(8)
    public var sectionGeneralCornerRadius: CGFloat = CGFloat(5)
    
    // MARK: Section Headers
    public var sectionHeaderHeight: CGFloat {
        return sectionGeneralHeight
    }
    public var sectionHeaderTitleFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote).pointSize)!
    public var sectionHeaderTitleColor = UIColor.white
    public var sectionHeaderBackgroundColor = UIColor(hex: "FF5E3A")
    public var sectionHeaderAlpha: CGFloat = 1.0
    public var sectionHeaderLeftButtonTintColor: UIColor = UIColor(hex: "bdc3c7")
    public var sectionHeaderRightButtonTintColor: UIColor = UIColor(hex: "bdc3c7")
    
    // MARK: Section Table
    public var sectionTableHeightImage: CGFloat {
        return self.sectionGeneralHeight
    }
    public var sectionTableDeactiveCornerColor: UIColor = UIColor(hex: "e4e4e4")
    public var sectionTableDeactiveColor: UIColor = UIColor(hex: "c3c3c3")
    public var sectionTableActiveCornerColor: UIColor = UIColor(hex: "04970a")
    public var sectionTableActiveColor: UIColor = UIColor(hex: "ffffff")
    public var sectionTableFontRow: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    
    // MARK: Section View
    public var sectionViewBackgroundColor: UIColor = UIColor(hex: "f8f7f4")
    public var sectionViewSeperatorColor: UIColor = UIColor(hex: "e8e6e1")
    
    // MARK: Section Popup
    public var sectionPopupBlurAlpha: CGFloat = CGFloat(0.75)
    public var sectionPopupBlurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    public var sectionPopupCornerRadius: CGFloat = CGFloat(5)
    public var sectionPopupMarginMultiplier: CGFloat = CGFloat(0.10)
    public var sectionPopupBackgroundColor: UIColor = UIColor.white
    
    // MARK: Section Input
    public var sectionInputFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    public var sectionInputIconColor: UIColor = UIColor(hex: "e4e4e4")
    public var sectionInputLeftPadding: CGFloat = CGFloat(3)
    
    // MARK: Section Segment Control
    public var sectionSegmentControlFont: UIFont {
        return self.sectionTableFontRow
    }
    public var sectionSegmentContrlTitleColor: UIColor = .white
    public var sectionSegmentContrlTintColor: UIColor {
        return self.sectionStepperPlusIconColor
    }
    
    // MARK: Section Picker View
    public var sectionPickerViewItemFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    public var sectionPickerViewItemColor: UIColor = UIColor.black
    
    // MARK: Section Date Pickerview
    public var sectionDatePickerViewFormatDate: String = "yyyy/mm/dd"
    public var sectionDatePickerViewFormatTime: String = "HH:mm:ss"
    
    // MARK: Section Loader
    public var sectionLoaderColor: UIColor = UIColor.black
    public var sectionLoaderCornerRadius: CGFloat {
        return self.sectionGeneralCornerRadius
    }
    public var sectionLoaderBlurAlpha: CGFloat = CGFloat(0.75)
    public var sectionLoaderBlurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    public var sectionLoaderBlurBackgroundColor: UIColor = UIColor(hex: "efefef")
    
    // MARK: Section Refresh Control
    public var sectionRefreshControlFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote).pointSize)!
    public var sectionRefreshControlColor: UIColor = UIColor.black
    
    // MARK: Section Stepper
    public var sectionStepperPlusIconColor: UIColor = UIColor(hex: "ef6125")
    public var sectionStepperPlusBackgroundColor: UIColor = UIColor(hex: "590a30")
    public var sectionStepperMinusIconColor: UIColor {
        get{
            return self.sectionStepperPlusIconColor
        }
    }
    public var sectionStepperMinusBackgroundColor: UIColor {
        get{
            return self.sectionStepperPlusBackgroundColor
        }
    }
    public var sectionStepperInputBackgroundColor: UIColor = UIColor(hex: "90aa3c")
    public var sectionStepperInputTextColor: UIColor = UIColor.black
    public var sectionStepperInputFont: UIFont {
        get{
            return UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2).pointSize)!
        }
    }
    public var sectionStepperCornerRadius: CGFloat {
        return CGFloat(3)
    }
    
    // MARK: Section Notifications
    public var sectionNotificationFont: UIFont {
        get{
            return UIFont(name: AZFontString.shared.bold, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
        }
    }
    public var sectionNotificationBackgroundColor: UIColor = UIColor.black
    public var sectionNotificationColor: UIColor = UIColor.white
    public var sectionNotificationTintButtonColor: UIColor = UIColor.white
        // type
    public var sectionNotificationTypeInformationColor: UIColor = UIColor(hex: "00529B")
    public var sectionNotificationTypeInformationBackgroundColor: UIColor = UIColor(hex: "BDE5F8")
    public var sectionNotificationTypeSuccessColor: UIColor = UIColor(hex: "4F8A10")
    public var sectionNotificationTypeSuccessBackgroundColor: UIColor = UIColor(hex: "DFF2BF")
    public var sectionNotificationTypeWarningColor: UIColor = UIColor(hex: "9F6000")
    public var sectionNotificationTypeWarningBackgroundColor: UIColor = UIColor(hex: "FEEFB3")
    public var sectionNotificationTypeErrorColor: UIColor = UIColor(hex: "D8000C")
    public var sectionNotificationTypeErrorBackgroundColor: UIColor = UIColor(hex: "FFBABA")
    
    public var sectionNotificationCornerRadius: CGFloat {
        return self.sectionGeneralCornerRadius
    }
    
    // MARK: Theme
    public let availableThemes = ["apple", "lightGray"]
    
    public func loadTheme(){
        
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
