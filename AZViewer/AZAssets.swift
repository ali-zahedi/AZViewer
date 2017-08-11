//
//  AZAssets.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

class AZFontString {
    
    // MARK: Public
    static let shared = AZFontString()
    private init() {
        AZAssets.bundledLoadFont()
    } //This prevents others from using the default '()' initializer for this class.
    
    /*
     case ultraLight = "IRANSansMobile-UltraLight"
     case light = "IRANSansMobile-Light"
     case regular = "IRANSansMobile"
     case medium = "IRANSansMobile-Medium"
     case bold = "IRANSansMobile-Bold"
     */
    var ultraLight = "IRANSansMobileFaNum-UltraLight"
    var light = "IRANSansMobileFaNum-Light"
    var regular = "IRANSansMobileFaNum"
    var medium = "IRANSansMobileFaNum-Medium"
    var bold = "IRANSansMobileFaNum-Bold"
    
}

/// AZAssets provides a set of default images, that can be supplied to the views.
open class AZAssets: NSObject {
    
    open class var closeImage: UIImage { return AZAssets.bundledImage(named: "close") }
    open class var plusImage: UIImage { return AZAssets.bundledImage(named: "plus") }
    open class var minusImage: UIImage { return AZAssets.bundledImage(named: "minus") }
    open class var tickImage: UIImage { return AZAssets.bundledImage(named: "tick") }
    open class var expandImage: UIImage { return AZAssets.bundledImage(named: "expand") }
    open class var shutterImage: UIImage { return AZAssets.bundledImage(named: "shutter") }
    
    internal class func bundledImage(named name: String) -> UIImage {
        let bundle = Bundle(for: AZAssets.self)
        let image = UIImage(named: name, in:bundle, compatibleWith:nil)
        if let image = image {
            return image
        }
        
        return UIImage()
    }
    
    internal class func bundledLoadFont() {
        let bundle = Bundle(for: AZAssets.self)
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
    
    internal class func printAllFont(){
        for familyName in UIFont.familyNames {
            print("\n-- \(familyName) \n")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
    }
}
