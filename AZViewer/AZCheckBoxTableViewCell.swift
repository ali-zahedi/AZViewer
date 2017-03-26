//
//  AZCheckBoxTableViewCell.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

class AZCheckBoxTableViewCell: UITableViewCell {
    
    // public
    static var font: UIFont = UIFont.systemFont(ofSize: 13)
    
    var dataSource: AZCheckBoxDataSource! {
        didSet{
            self.updateUI()
        }
    }
    
    var checkBoxImageView: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    
    // private 
    fileprivate static let heightOfCheckBoxImageView: CGFloat = CGFloat(25)
    fileprivate static let deactiveCornerColor: UIColor = AZView.hexStringToUIColor(hex: "e4e4e4")
    fileprivate static let deactiveColor: UIColor = AZView.hexStringToUIColor(hex: "c3c3c3")
    fileprivate static let activeCornerColor: UIColor = AZView.hexStringToUIColor(hex: "04970a")
    fileprivate static let activeColor: UIColor = AZView.hexStringToUIColor(hex: "ffffff")
    
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
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: AZCheckBoxTableViewCell.heightOfCheckBoxImageView).isActive = true
        NSLayoutConstraint(item: self.checkBoxImageView, attribute: .width, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        self.checkBoxImageView.contentMode = .scaleAspectFit
        self.checkBoxImageView.layer.cornerRadius = AZCheckBoxTableViewCell.heightOfCheckBoxImageView / 2
        self.checkBoxImageView.image = UIImage(named: "tick", in: AZView.bundle, compatibleWith: nil)
        
    }
    
    // title
    fileprivate func prepareTitle(){
        
        NSLayoutConstraint(item: self.title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .right, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .left, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: self.title, attribute: .height, relatedBy: .equal, toItem: self.checkBoxImageView, attribute: .height, multiplier: 5, constant: 0).isActive = true
        
        self.title.textAlignment = .right
        self.title.font = AZCheckBoxTableViewCell.font
        self.title.numberOfLines = 0
        
    }
    
    fileprivate func updateUI(){
        
        self.title.text = self.dataSource.title
        self.setupAnimationActive()
    }
    
    public func setupAnimationActive(){
        
        var color1: UIColor = AZCheckBoxTableViewCell.deactiveCornerColor
        var color2: UIColor = AZCheckBoxTableViewCell.deactiveColor
        
        if dataSource.isActive {
        
            color1 = AZCheckBoxTableViewCell.activeCornerColor
            color2 = AZCheckBoxTableViewCell.activeColor
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { 
            self.checkBoxImageView.backgroundColor = color1
            self.checkBoxImageView.tintColor = color2
            }, completion: nil)
        
        
    }
    
}
