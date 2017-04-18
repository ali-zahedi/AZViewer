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
    public var date: Date {
        
        var string: String = ""
        
        for i in (0...(self.data.count - 1)){
            
            // check array range
            if let row = self.index[i],  self.data[i].count > row{
                
                string += self.data[i][row].1 + "/"
            }
        }
        
        string = string.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        // TODO: check and create date form format date !
        let date: Date = self.formatterPersian.date(from: string)!
        
        return date
    }
    
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
    fileprivate var calenderComponentMin: DateComponents!
    fileprivate var calenderComponentMax: DateComponents!
    // index
    fileprivate var yearsIndexFormat: Int = 0
    fileprivate var monthsIndexFormat: Int = 1
    fileprivate var daysIndexFormat: Int = 2
    // date
    fileprivate var years: [(AnyObject, String)] = [] {
        didSet{
            self.data[self.yearsIndexFormat] = self.years
        }
    }
    fileprivate var months: [(AnyObject, String)] = []{
        didSet{
            
            // TODO: Check if monthindex format opposite of 1 do it work? or for years and days
            if !(self.data.count > self.monthsIndexFormat) {
                self.data.append([])
            }
            
            self.data[self.monthsIndexFormat] = self.months
        }
    }
    fileprivate var days: [(AnyObject, String)] = [] {
        didSet{
            
            if !(self.data.count > self.daysIndexFormat) {
                self.data.append([])
            }
            
            self.data[self.daysIndexFormat] = self.days
        }
    }
    
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

// generate range
extension AZPopupDatePickerView{
    // range
    fileprivate func generateRange(){
        
        self.calenderComponentMin = self.formatterPersian.calendar.dateComponents(self.calenderComponentOptions, from: self.minimumDateTime)
        self.calenderComponentMax = self.formatterPersian.calendar.dateComponents(self.calenderComponentOptions, from: self.maximumDateTime)
        
        guard  let _ = self.calenderComponentMin.year , let _ = self.calenderComponentMax.year else{
            NSLog("AZView date is invalide \(self.minimumDateTime) , \(self.maximumDateTime)")
            return
        }
        
        // TODO: change number of day after set month
        self.generateRangeYears()
    }
    
    // year
    fileprivate func generateRangeYears(){
        
        var years: [(AnyObject, String)] = []
        
        for year in self.calenderComponentMin.year!...self.calenderComponentMax.year!{
            years.append((year as AnyObject, year.description))
        }
        
        self.years = years
    }
    
    // month
    fileprivate func generateRangeMonths(yearTouple: (AnyObject, String)){
        
        let year: Int = Int(yearTouple.0 as! NSNumber)
        var months: [(AnyObject, String)] = []
        
        if  year > self.calenderComponentMin.year! && year < self.calenderComponentMax.year! {
            
            for month in 1...12{
                months.append((month as AnyObject, month.description))
            }
        }else if year == self.calenderComponentMin.year {
            
            for month in self.calenderComponentMin.month!...12{
                months.append((month as AnyObject, month.description))
            }
        }else{
            
            for month in 1...self.calenderComponentMax.month!{
                months.append((month as AnyObject, month.description))
            }
        }
        
        if self.months.count != months.count{
            self.months = months
        }
    }
    
    // days
    fileprivate func generateRangeDays(monthTouple: (AnyObject, String)){
        
        let month: Int = Int(monthTouple.0 as! NSNumber)
        var days: [(AnyObject, String)] = []
        if month < 7 {
            for day in 1...31{
                days.append((day as AnyObject, day.description))
            }
        }else if month >= 7 && month < 12 {
            
            for day in 1...30{
                days.append((day as AnyObject, day.description))
            }
            
        }else{
            
            // TODO: check years kabise
            for day in 1...29{
                days.append((day as AnyObject, day.description))
            }
        }
        
        if self.days.count != days.count{
            self.days = days
        }
    }
    
}

extension AZPopupDatePickerView{
    
    override public func aZPickerView(didSelectRow row: Int, inComponent component: Int) {
        super.aZPickerView(didSelectRow: row, inComponent: component)
        
        if component == self.yearsIndexFormat {
            self.generateRangeMonths(yearTouple: self.years[row])
        }else if component == self.monthsIndexFormat {
            self.generateRangeDays(monthTouple: self.months[row])
        }
    }
    
    public func selected(date: Date) {
        
        let defaultDate: String = self.formatterPersian.string(from: date)
        // TODO: Check seperator
        let defaultDateArray = defaultDate.characters.split(separator: "/").map(String.init)
        let year = defaultDateArray[0]
        let month = defaultDateArray[1]
        let day = defaultDateArray[2]
        
        func findIndexDate(indexDate: Int, compare: String){
            for (index, d) in self.data[indexDate].enumerated(){
                if d.1 == compare {
                    self.selected(indexPath: IndexPath(row: index, section: indexDate))
                    break
                }
            }
        }
        // year
        findIndexDate(indexDate: 0, compare: year)
        // month
        findIndexDate(indexDate: 1, compare: month)
        // day
        findIndexDate(indexDate: 2, compare: day)
    }
}
