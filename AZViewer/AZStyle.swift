//
//  AZStyle.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/7/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

enum AZFontString: String {
    
    /*
     case ultraLight = "IRANSansMobile-UltraLight"
     case light = "IRANSansMobile-Light"
     case regular = "IRANSansMobile"
     case medium = "IRANSansMobile-Medium"
     case bold = "IRANSansMobile-Bold"
     */
    case ultraLight = "IRANSansMobileFaNum-UltraLight"
    case light = "IRANSansMobileFaNum-Light"
    case regular = "IRANSansMobileFaNum"
    case medium = "IRANSansMobileFaNum-Medium"
    case bold = "IRANSansMobileFaNum-Bold"
    
}

struct AZStyle{
    
    static var loadFont: Bool = AZLoadFont.loadFont()
    
    // MARK: Section Headers
    static var sectionHeaderHeight: CGFloat = CGFloat(30)
    static var sectionHeaderTitleFont = UIFont(name: AZFontString.bold.rawValue, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    static var sectionHeaderTitleColor = UIColor.black
    static var sectionHeaderAlpha: CGFloat = 1.0
    
    // MARK: Section Table
    static var sectionTableRow: UIFont = UIFont(name: AZFontString.regular.rawValue, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    
    // MARK: Section View
    static var sectionViewBackgroundColor: UIColor = AZView.hexStringToUIColor(hex: "f8f7f4")
    static var sectionViewSeperatorColor: UIColor = AZView.hexStringToUIColor(hex: "e8e6e1")
    
    // MARK: Section Input
    static var sectionInputFont: UIFont = UIFont(name: AZFontString.regular.rawValue, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body).pointSize)!
    
    static let availableThemes = ["apple", "lightGray"]
    
    static func loadTheme(){
        _ = AZLoadFont.loadFont()

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
            defaults.set("Apple", forKey: "AZTheme")
            themeMaster()
        }
    }
    
    // MARK: Blue Color Schemes
    static func themeMaster(){
        // MARK: ToDo Table Section Headers
//        sectionHeaderTitleFont = UIFont(name: "Helvetica-Bold", size: 20)
//        sectionHeaderTitleColor = UIColor.white
//        sectionHeaderBackgroundColor = UIColor.blue
//        sectionHeaderAlpha = 0.8
    }
    
    // MARK: Light Gray Color Schemes
    static func themeLightGray(){
        
    }
    
    
    static func printAllFont(){
        for familyName in UIFont.familyNames {
            print("\n-- \(familyName) \n")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
    }
}

struct AZLoadFont{
    static var load: Bool = false
    
    static func loadFont() -> Bool{
    
        if !load {
            load  = true
            loadFontProgress()
        }
        
        return load
    }
    
    fileprivate static func loadFontProgress(){
        
        // Load bundle which hosts the font files. Bundle has various ways of locating bundles.
        // This one uses the bundle's identifier
        let bundle = AZView.bundle
        // List the fonts by name and extension, relative to the bundle
        let fonts = [
            bundle.url(forResource: "IRANSansMobile(FaNum)_Bold", withExtension: "ttf"),
            bundle.url(forResource: "IRANSansMobile(FaNum)_Light", withExtension: "ttf"),
            bundle.url(forResource: "IRANSansMobile(FaNum)_Medium", withExtension: "ttf"),
            bundle.url(forResource: "IRANSansMobile(FaNum)_UltraLight", withExtension: "ttf"),
            bundle.url(forResource: "IRANSansMobile(FaNum)", withExtension: "ttf"),
            ]
        // Iterate over the urls, filtering out nil-values with .flatMap()
        for url in fonts.flatMap({ $0 }) {
            // Create a CGDataPRovider and a CGFont from the URL.
            // Register the font with the system.
            if let dataProvider = CGDataProvider(url: url as CFURL) {
                let font = CGFont(dataProvider)
                CTFontManagerRegisterGraphicsFont(font, nil)
            }
        }
        
    }
}
