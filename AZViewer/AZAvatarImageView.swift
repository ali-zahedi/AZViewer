//
//  AZAvatarImageView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 4/2/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZAvatarView: AZView{
    
    // MARK: Public
    public var isCircle: Bool! {
        didSet{
            self.circle()
        }
    }
    
    public var font: UIFont! {
        didSet{
            self.labelView.font = self.font
        }
    }
    // text label
    public var text: String {
        set{
            
            self._text = newValue
        }get{
            
            return self._text
        }
    }
    
    // url
    public var url: String{
        set{
            
            self._url = newValue
        }get{
            
            return self._url
        }
    }
    
    // image
    public var image: UIImage {
        set{
            
            self._image = newValue
        }get{
            
            return self._image
        }
    }
    
    // MARK: Private
    fileprivate var imageView: AZImageView = AZImageView()
    fileprivate var labelView: AZLabel = AZLabel()
    
    // text label
    fileprivate var _text: String = "" {
        didSet{
            self.imageViewHidden(true)
            self.labelView.text = self.towordText(txt: self.text)
            self.labelView.backgroundColor = AZColor(hSS: self.labelView.text!)
        }
    }
    
    // url
    fileprivate var _url: String = ""{
        didSet{
            
            self.imageViewHidden(false)
            
            AZImageLoader.shared.imageForUrl(urlString: url) { (image, url) in
                self.imageView.image = image
            }
        }
    }
    
    // image
    fileprivate var _image: UIImage = UIImage(){
        didSet{
            self.imageViewHidden(false)
            self.imageView.image = image
        }
    }
    
    // MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // text
    public convenience init(text: String, isCircle: Bool = false, frame: CGRect? = nil){
        
        self.init(isCircle: isCircle, frame: frame)
        self.text = text
    }
    
    // url
    public convenience init(url: String, isCircle: Bool = false, frame: CGRect? = nil){
        
        self.init(isCircle: isCircle, frame: frame)
        self.url = url
    }
    
    // image
    public convenience init(image: UIImage, isCircle: Bool = false, frame: CGRect? = nil){
        
        
        self.init(isCircle: isCircle, frame: frame)
        self.image = image
    }
    
    public convenience init(isCircle: Bool = false, frame: CGRect? = nil){
        
        let f = frame ?? CGRect(x: 0, y: 0, width: 50, height: 50)
        self.init(frame: f)
        self.isCircle = isCircle
    }
    
    // MARK: Override
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.circle()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
        self.backgroundColor = .clear
        self.font = self.style.sectionAvatarViewFont
        self.isCircle = false
        
        // add to subview
        for v in [imageView, labelView] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // prepare
        self.prepareLabelView()
        self.prepareImageView()
    }
    
    // circle
    fileprivate func circle(){
        
        if self.isCircle{
            
            self.clipsToBounds = true
            self.layer.cornerRadius = self.bounds.height / 2
        }else{
            
            self.clipsToBounds = false
            self.layer.cornerRadius = 0
        }
    }
    
    // hidden
    fileprivate func imageViewHidden(_ sender: Bool){
        self.imageView.isHidden = sender
        self.labelView.isHidden = !sender
    }
    
    // split sttring
    func towordText(txt:String)->String{
        
        var result: String!
        if (txt.contains(" ")) {
            
            let firstIndex = txt.index(txt.startIndex, offsetBy: 0)
            let secondIndex = txt.index(txt.range(of: " ")!.upperBound, offsetBy: 0)
            
            result = String(txt[firstIndex]) + " " + String(txt[secondIndex])
        }
        else{
            
            result = String(txt[txt.index(txt.startIndex, offsetBy: 0)]) + " " + String(txt[txt.index(txt.startIndex, offsetBy: 1)])
        }
        
        return result
    }
}

// prepare
extension AZAvatarView{
    
    // imageView
    fileprivate func prepareImageView(){
        _ = self.imageView.aZConstraints.parent(parent: self).top().left().right().bottom()
        self.imageView.isHidden = true
    }
    
    // labelView
    fileprivate func prepareLabelView(){
        _ = self.labelView.aZConstraints.parent(parent: self).top().left().right().bottom()
        self.labelView.isHidden = true
        self.labelView.textColor = .white
        self.labelView.textAlignment = .center
    }
}
