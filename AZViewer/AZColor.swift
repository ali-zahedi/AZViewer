//
//  UIColor+hex.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/15/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZColor: UIColor{
    
    public convenience init(hex: String) {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
    }
    
    public convenience init?(hSS: String) {
        let r, g, b, a: CGFloat!
        let colorArray = ["#607D8Bff" ,"#FF5722ff" ,"#9E9E9Eff","#FFEA00ff","#FF9100ff","#8BC34Aff","#4CAF50ff","#CDDC39ff","#00BCD4ff","#009688ff","#673AB7ff","#3F51B5ff","#2196F3ff","#F44336ff","#E91E63ff","#9C27B0ff","#E91E63ff","#E91E63ff","#26A69Aff","#546E7Aff"]
        
        let cStrings = hSS.unicodeScalars.map { $0.value }

        var log:Int64 = 1

        for cs in cStrings {
            
            log = Int(cs) != 32 ? log * Int64(cs) : log ;
        }

        var val = 0

        if (log  > 100 ){
            
            let logString = String(log)
            // range
            let start = logString.index(logString.endIndex, offsetBy: -3)
            let range = start..<logString.endIndex
            val =  Int(logString[range])!
        }else {
            
            val = Int(log)
        }

        let tochar  = val < 20 ? val : val % 19 ;
        
        let hexString: String = colorArray[tochar < 1 ? 0 : tochar - 1 ]
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
}
