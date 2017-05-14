//
//  AZRefreshControl.swift
//  AZViewer
//
//  Created by Ali Zahedi on 2/19/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import UIKit

public class AZRefreshControl: UIRefreshControl{
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    // MARK: Public
    public var loader: AZLoader{
        return self.loaderView.loader
    }
    
    public var text: String = "" {
        didSet{
            self.title.text = self.text
        }
    }
    public var title: AZLabel = AZLabel()
    public var dateFormat: String = "HH:mm:ss dd/MMMM/yyyy" {
        didSet{
            self.formatterPersian.dateFormat = self.dateFormat
        }
    }
    
    // MARK: Private
    fileprivate var loaderView: AZView = AZView()
    fileprivate var formatterPersian: DateFormatter!
    
    // MARK: Init
    override public init() {
        super.init()
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Override
    public override func beginRefreshing() {
        super.beginRefreshing()
        self.loader.isActive = true
        let date = Date()
        self.title.text = self.formatterPersian.string(from: date)
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        self.loader.isActive = false
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
        // fix color
        self.tintColor = UIColor.clear
        
        // add view
        for v in [loaderView, title] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // persian formatter
        self.prepareFormatterPersian()
        
        // loader
        self.prepareLoader()
        
        // title
        self.prepareTitleLabel()
    }
    
}

// prepare
extension AZRefreshControl{
    
    //loader
    fileprivate func prepareLoader(){
        self.loader.blurIsHidden = true
        self.loader.horizontalAlignment = .middle
        
        _ = self.loaderView.aZConstraints.parent(parent: self).top().right().left().height(to: self, multiplier: 0.7)
    }
    
    //tilte
    fileprivate func prepareTitleLabel(){
        _ = self.title.aZConstraints.parent(parent: self).top(to: self.loaderView, toAttribute: .bottom).right().left().bottom()
        self.title.font = AZStyle.shared.sectionRefreshControlFont
        self.title.textColor = AZStyle.shared.sectionRefreshControlColor
        self.title.textAlignment = .center
    }
    
    // calender
    fileprivate func prepareFormatterPersian(){
        self.formatterPersian = DateFormatter()
        self.formatterPersian.dateFormat = self.dateFormat
        self.formatterPersian.locale = Locale(identifier:"fa_IR")
//        self.formatterPersian.dateStyle = .l
        self.formatterPersian.calendar = Calendar(identifier: .persian)
    }
}
