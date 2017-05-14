//
//  AZCheckBoxTableViewCell.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

class AZCheckBoxTableViewCell: UITableViewCell {
    
    // MARK: Public
    var titleFont: UIFont! {
        didSet{
            self.title.font = self.titleFont
        }
    }
    
    // MARK: Internal
    var activeStyle: AZCheckBox.Style!
    var diActiveStyle: AZCheckBox.Style!
    
    var dataSource: AZCheckBoxDataSource! {
        didSet{
            self.updateUI()
        }
    }
    
    var checkBoxImageView: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    
    // MARK: Private
    fileprivate var style: AZStyle = AZStyle.shared
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    fileprivate func defaultInit(){
        
        for v in [checkBoxImageView, title] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            v.clipsToBounds = true
            self.addSubview(v)
        }
        
        self.prepareImageView()
        self.prepareTitle()
    }
    
    // image view
    fileprivate func prepareImageView(){
        
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.style.sectionTableHeightImage).isActive = true
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .width, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        self.checkBoxImageView.contentMode = .scaleAspectFit
        
    }
    
    // title
    fileprivate func prepareTitle(){
        
        NSLayoutConstraint(item: self.title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .right, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .left, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .height, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .height, multiplier: 5, constant: 0).isActive = true
        
        self.title.textAlignment = .right
//        self.titleFont = self.style.sectionTableFontRow
        self.title.numberOfLines = 0
        
    }
    
    fileprivate func updateUI(){
        
        self.title.text = self.dataSource.title
        self.setupAnimationActive()
    }
    
    public func setupAnimationActive(){
        
        var style: AZCheckBox.Style = self.diActiveStyle
        if dataSource.isActive {
        
            style = self.activeStyle
        }
        
        self.checkBoxImageView.layer.cornerRadius = style.cornerRadius
            
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.checkBoxImageView.image = style.image
            self.checkBoxImageView.backgroundColor = style.backgroundColor
            self.checkBoxImageView.tintColor = style.tintColor
            }, completion: nil)
        
        
    }
    
}
