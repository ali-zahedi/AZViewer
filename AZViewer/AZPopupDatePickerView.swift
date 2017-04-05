//
//  AZPopupDatePickerView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/16/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZPopupDatePickerView: AZPopupPickerView{
    
    // MARK: Public
    
    // MARK: IBOutlet
    @IBInspectable public var formatDate: String = AZStyle.shared.sectionDatePickerViewFormatDate
        {
        didSet{
            self.updateUI()
        }
    }
    @IBInspectable public var formatTime: String = AZStyle.shared.sectionDatePickerViewFormatTime{
        didSet{
            self.updateUI()
        }
    }
    
    @IBInspectable public var minimumDateTime: Date = Date(){
        didSet{
            self.updateUI()
        }
    }
    @IBInspectable public var maximumDateTime: Date = Date(){
        didSet{
            self.updateUI()
        }
    }
    
    // MARK: Private
    fileprivate var formatterGregorian: DateFormatter!
    fileprivate var formatterPersian: DateFormatter!
    fileprivate var calenderComponentOptions: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    fileprivate var years: [String] = []
    fileprivate var months: [String] = []
    fileprivate var day: [String] = []
    
    // override
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
        
        for v in [] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.updateUI()
        
    }
    
    // update ui
    fileprivate func updateUI(){
        self.prepareFormatterGregorian()
        self.prepareFormatterPersian()
        self.generateRange()
    }
    
    // range
    fileprivate func generateRange(){
        
        let cMin = self.formatterPersian.calendar.dateComponents(self.calenderComponentOptions, from: self.minimumDateTime)
        let cMax = self.formatterPersian.calendar.dateComponents(self.calenderComponentOptions, from: self.maximumDateTime)
        
        guard let yearMin = cMin.year , let yearMax = cMax.year else{
            NSLog("AZView date is invalide \(self.minimumDateTime) , \(self.maximumDateTime)")
            return
        }

        // TODO: change number of day after set month
        print("\(yearMin), \(yearMax)")
    }
}

// prepare
extension AZPopupDatePickerView{
    
    // formattter gregorian
    fileprivate func prepareFormatterGregorian(){
        self.formatterGregorian = DateFormatter()
        // TODO: how to check formatter for time and date
        self.formatterGregorian.dateFormat = self.formatDate
        self.formatterGregorian.calendar = Calendar(identifier: .gregorian)
        //        let date = Date()
        //        let dateInGrogrian = formatter.string(from: date)
    }
    
    fileprivate func prepareFormatterPersian(){
        //        let dateInGrogrian = formatter.date(from: <#T##String#>)
        // print(dateInGrogrian)
        self.formatterPersian = DateFormatter()
        // TODO: how to check formatter for time and date
        self.formatterPersian.dateFormat = self.formatDate
        self.formatterPersian.calendar = Calendar(identifier: .persian)
        self.formatterPersian.dateFormat = self.style.sectionDatePickerViewFormatDate
//        print("Converted date to Hijri = \(self.formatterGregorian.string(from: date))")
    }
}
