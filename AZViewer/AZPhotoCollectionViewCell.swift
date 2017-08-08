//
//  AZPhotoCollectionViewCell.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/22/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import UIKit

class AZPhotoCollectionViewCell: AZCollectionViewCell {
    
    // MARK: Public
    
    // MARK: Internal
    static var size: CGSize{
        let wh: CGFloat = (UIScreen.main.bounds.width / 4 ) - (AZPhotoCollectionView.spacing * 1.5)
        return CGSize(width: wh, height: wh)
    }
    
    var object: AZModelPhoto! {
        didSet{
            self.updateUI()
        }
    }
    
    // MARK: Private
    fileprivate var imageView: AZImageView = AZImageView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
        for v in [imageView] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.prepareImageView()
    }
    
    // update
    fileprivate func updateUI(){
        
        self.imageView.image = self.object.image
        self.prepareBorder()
        
    }
    
    // update border
    func selected(){
        
        self.object.selected = !self.object.selected
        self.prepareBorder()
    }
    
    fileprivate func prepareBorder(){
        
        if self.object.selected{
            
            self.setBorder()
        }else{
            
            self.clearBorder()
        }
    }
    
    fileprivate func setBorder(){
        
        self.imageView.layer.borderColor = AZStyle.shared.sectionPhotoViewControllerImageSelectedTintColor.cgColor
        self.imageView.layer.borderWidth = 2
    }
    
    fileprivate func clearBorder(){
        
        self.imageView.layer.borderWidth = 0
    }
}

// prepare
extension AZPhotoCollectionViewCell{
    
    // image view
    fileprivate func prepareImageView(){
     
        _ = self.imageView.aZConstraints.parent(parent: self).top().right().left().bottom()
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }
}
