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
    
    // MARK: Shortcut
    public var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    // MARK: General
    public var sectionGeneralHeight: CGFloat = CGFloat(30)
    public var sectionGeneralConstant: CGFloat = CGFloat(8)
    public var sectionGeneralCornerRadius: CGFloat = CGFloat(5)

    // MARK: Section Headers
    public var sectionHeaderHeight: CGFloat = CGFloat(40)
    public var sectionHeaderTitleFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote).pointSize)!
    public var sectionHeaderTitleColor = UIColor.white
    public var sectionHeaderBackgroundColor = AZColor(hex: "FF5E3A")
    public var sectionHeaderAlpha: CGFloat = 1.0
    public var sectionHeaderLeftButtonTintColor: UIColor = AZColor(hex: "bdc3c7")
    public var sectionHeaderRightButtonTintColor: UIColor = AZColor(hex: "bdc3c7")
    
    // MARK: Section Table
    public var sectionTableHeightImage: CGFloat {
        return self.sectionGeneralHeight
    }
    public var sectionTableDeactiveCornerColor: UIColor = AZColor(hex: "e4e4e4")
    public var sectionTableDeactiveColor: UIColor = AZColor(hex: "c3c3c3")
    public var sectionTableActiveCornerColor: UIColor = AZColor(hex: "04970a")
    public var sectionTableActiveColor: UIColor = AZColor(hex: "ffffff")
    public var sectionTableFontRow: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    
    // MARK: Section View
    public var sectionViewBackgroundColor: UIColor = AZColor(hex: "f8f7f4")
    public var sectionViewSeperatorColor: UIColor = AZColor(hex: "e8e6e1")
    
    // MARK: Section photo controller
    public var sectionPhotoViewControllerBottomBarColor: UIColor = AZColor(hex: "e8e6e1")
    public var sectionPhotoViewControllerBottomBarHeight: CGFloat = CGFloat(40)
    public var sectionPhotoViewControllerBottomBarButtonColor: UIColor = .white
    public var sectionPhotoViewControllerBottomBarButtonActiveColor: UIColor = .black
    public var sectionPhotoViewControllerTitleLibrary: String = "گالری تصاویر"
    public var sectionPhotoViewControllerFontLibrary: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    public var sectionPhotoViewControllerTitleTakePhoto: String = "دوربین"
    public var sectionPhotoViewControllerFontTakePhoto: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    public var sectionPhotoViewControllerTitleTakeVideo: String = "فیلم"
    public var sectionPhotoViewControllerFontTakeVideo: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1).pointSize)!
    public var sectionPhotoViewControllerTakePhotoBottomViewColor: UIColor = AZColor(hex: "f8f7f4")
    public var sectionPhotoViewControllerTakePhotoImage: UIImage = AZAssets.shutterImage
    public var sectionPhotoViewControllerTakePhotoImageTintColor: UIColor = AZColor(hex: "fffff")
    public var sectionPhotoViewControllerImageSelectedTintColor: UIColor = AZColor(hex: "e8e6e1")
    
    // MARK: Section Popup
    public var sectionPopupBlurAlpha: CGFloat = CGFloat(0.75)
    public var sectionPopupBlurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    public var sectionPopupCornerRadius: CGFloat = CGFloat(5)
    public var sectionPopupMarginMultiplier: CGFloat = CGFloat(0.10)
    public var sectionPopupBackgroundColor: UIColor = UIColor.white
    
    // MARK: Section Input
    public var sectionInputFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    public var sectionInputIconColor: UIColor = AZColor(hex: "e4e4e4")
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
    public var sectionPickerViewItemColor: UIColor = AZColor.black
    
    // MARK: Section AvatarView
    public var sectionAvatarViewFont: UIFont {
        return self.sectionPickerViewItemFont
    }
    
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
    public var sectionLoaderBlurBackgroundColor: UIColor = AZColor(hex: "efefef")
    
    // MARK: Section Refresh Control
    public var sectionRefreshControlFont: UIFont = UIFont(name: AZFontString.shared.regular, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote).pointSize)!
    public var sectionRefreshControlColor: UIColor = UIColor.black
    
    // MARK: Section Stepper
    public var sectionStepperPlusIconColor: UIColor = AZColor(hex: "ef6125")
    public var sectionStepperPlusBackgroundColor: UIColor = AZColor(hex: "590a30")
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
    public var sectionStepperInputBackgroundColor: UIColor = AZColor(hex: "90aa3c")
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
    public var sectionNotificationTypeInformationColor: UIColor = AZColor(hex: "00529B")
    public var sectionNotificationTypeInformationBackgroundColor: UIColor = AZColor(hex: "BDE5F8")
    public var sectionNotificationTypeSuccessColor: UIColor = .white//AZColor(hex: "4F8A10")
    public var sectionNotificationTypeSuccessBackgroundColor: UIColor = AZColor(hex: "25D366")
    public var sectionNotificationTypeWarningColor: UIColor = AZColor(hex: "9F6000")
    public var sectionNotificationTypeWarningBackgroundColor: UIColor = AZColor(hex: "FEEFB3")
    public var sectionNotificationTypeErrorColor: UIColor = .white //AZColor(hex: "D8000C")
    public var sectionNotificationTypeErrorBackgroundColor: UIColor = AZColor(hex: "f44336")
    
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
