//
//  AZCheckBox.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

public class AZCheckBox: AZView {
    
    public var data: AZCheckBoxDataSection = AZCheckBoxDataSection() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    fileprivate var tableView: UITableView!
    fileprivate static let cellReuseIdentifier: String = "CheckBoxTableViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    fileprivate func defaultInit(){
        
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
    
        cell.dataSource = self.data.value[indexPath.row]
        
        // hidden last row seperator
        if indexPath.row == self.data.value.count - 1 {
            
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, tableView.bounds.width);
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
    }
    
}
