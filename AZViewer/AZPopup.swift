//
//  AZPopup.swift
//  Pods
//
//  Created by Ali Zahedi on 12/27/1395 AP.
//
//

import Foundation

public class AZPopupView: AZView{
    
    var button: AZButton!
    
    override public init(frame: CGRect){
        
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){
        
        self.prepareButton()
        
    }
    
    
}

// prepare section
extension AZPopupView{
    
    fileprivate func prepareButton(){
        // button
        self.button = AZButton()
        button.frame.size.width = self.frame.width
        button.frame.size.height = 50
        button.frame.origin.y = 0
        
        button.backgroundColor = UIColor.orange
        
        button.setTitle("Button", for: .normal)
//        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        self.addSubview(button)
        self.button.loader = true
//        button.setTitle("", for: .normal)
        
//        self.tapButton(sender: button)
    }
}
