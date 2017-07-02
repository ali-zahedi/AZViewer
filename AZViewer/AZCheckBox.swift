//
//  AZCheckBox.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

public protocol AZCheckBoxDelegate{
    
    func aZCheckBox(_ aZCheckBox: AZCheckBox, _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

public class AZCheckBox: AZView {
    
    // MARK: Public
    public var delegate: AZCheckBoxDelegate?
    public var hiddenEndSeparator: Bool = false
    public var hiddenSeparator: Bool = false {
        didSet{
            if self.hiddenSeparator{
                self.tableView.separatorStyle = .none
            }else{
                self.tableView.separatorStyle = .singleLine
            }
        }
    }
    
    public var data: AZCheckBoxDataSection = AZCheckBoxDataSection() {
        didSet{
            self.tableView.reloadData()
        }
    }
    public var font: UIFont = AZStyle.shared.sectionTableFontRow {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    // selected
    public struct Style{
        
        public var tintColor: UIColor
        public var backgroundColor: UIColor
        public var image: UIImage
        public var cornerRadius: CGFloat
        
    }
    
    public var activeStyle: AZCheckBox.Style!
    public var diActiveStyle: AZCheckBox.Style!
    
    // MARK: Private
    fileprivate var tableView: UITableView!
    fileprivate static let cellReuseIdentifier: String = "CheckBoxTableViewCell"
    
    // MARK: init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: function
    fileprivate func defaultInit(){
        
        self.diActiveStyle = Style(tintColor: self.style.sectionTableDeactiveColor, backgroundColor: self.style.sectionTableDeactiveCornerColor, image: AZAssets.tickImage, cornerRadius:self.style.sectionTableHeightImage / 2)
        
        self.activeStyle = Style(tintColor: self.style.sectionTableActiveColor, backgroundColor: self.style.sectionTableActiveCornerColor, image: AZAssets.tickImage, cornerRadius:self.style.sectionTableHeightImage / 2)
        
        self.prepareTableView()
    }
    
    // prepare tableview
    fileprivate func prepareTableView(){
        
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AZCheckBoxTableViewCell.self, forCellReuseIdentifier: AZCheckBox.cellReuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        
        NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
    }
    
    // MARK: Public
    // selct row in table
    public func select(indexPath: IndexPath){
        self.tableView(self.tableView, didSelectRowAt: indexPath)
    }
    
    // select all row 
    public func selectAll(){
    
        for row in 0..<self.data.value.count {
            self.select(indexPath: IndexPath(row: row, section: 0))
        }
    }
}

extension AZCheckBox: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AZCheckBox.cellReuseIdentifier, for: indexPath) as! AZCheckBoxTableViewCell
        cell.activeStyle = self.activeStyle
        cell.diActiveStyle = self.diActiveStyle
        
        cell.titleFont = self.font
        cell.dataSource = self.data.value[indexPath.row]
        
        // hidden last row seperator
        if indexPath.row == self.data.value.count - 1 && self.hiddenEndSeparator{
            
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, tableView.bounds.width * 1000);
        }
        
        return cell
        
    }
    
}

extension AZCheckBox: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! AZCheckBoxTableViewCell
        
        cell.dataSource.isActive = !cell.dataSource.isActive
        cell.setupAnimationActive()
        self.delegate?.aZCheckBox(self, tableView, didSelectRowAt: indexPath)
    }
    
}
