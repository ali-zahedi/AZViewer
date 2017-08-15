//
//  AZPhotoViewController.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/21/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import UIKit

public protocol AZPhotoDelegate{
    
    func submitPhoto(image: UIImage)
    
    func cancel()
}

public class AZPhotoViewController: UIViewController {
    
    // MARK: Public
    public var header: AZHeader = AZHeader()
    public var titleLibrary: String! {
        didSet{
            self.libraryButton.setTitle(self.titleLibrary, for: .normal)
        }
    }
    public var fontLibrary: UIFont! {
        didSet{
            self.libraryButton.titleLabel?.font = self.fontLibrary
        }
    }
    public var titleTakePhoto: String! {
        didSet{
            self.takePhotoButton.setTitle(self.titleTakePhoto, for: .normal)
        }
    }
    public var fontTakePhoto: UIFont! {
        didSet{
            self.takePhotoButton.titleLabel?.font = self.fontTakePhoto
        }
    }
    public var titleTakeVideo: String! {
        didSet{
            self.takeVideoButton.setTitle(self.titleTakeVideo, for: .normal)
        }
    }
    public var fontTakeVideo: UIFont! {
        didSet{
            self.takeVideoButton.titleLabel?.font = self.fontTakeVideo
        }
    }
    
    public var delegate: AZPhotoDelegate?
    public var images: [UIImage] = []
    
    // MARK: Private
    fileprivate var style: AZStyle = AZStyle.shared
    fileprivate var statusBar: AZView = AZView()
    fileprivate var bottomBar: AZView = AZView()
    fileprivate var libraryButton: AZButton = AZButton()
    fileprivate var takePhotoButton: AZButton = AZButton()
    fileprivate var takeVideoButton: AZButton = AZButton()
    fileprivate var imageView: AZImageView = AZImageView()
    fileprivate var collectionView: AZPhotoCollectionView = AZPhotoCollectionView()
    fileprivate var takePhotoView: AZPhotoTakePhotoView = AZPhotoTakePhotoView()

    // MARK: Internal
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: Init
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // default init
    fileprivate func defaultInit(){
        
        for v in [statusBar, header, imageView, collectionView, takePhotoView, bottomBar] as [UIView]{
            
            v.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(v)
        }
        
        self.prepareStatusBar()
        self.prepareHeader()
        self.prepareImageView()
        self.prepareCollectionView()
        self.prepareTakePhotoView()
        self.prepareBottomBar()
        
        self.view.backgroundColor = self.style.sectionViewBackgroundColor
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.takePhotoView.resetSize()
    }
}

// prepare
extension AZPhotoViewController{
    
    // status bar
    fileprivate func prepareStatusBar(){
        _ = self.statusBar.aZConstraints.parent(parent: self.view).top().right().left().height(constant: self.style.statusBarHeight)
        self.statusBar.backgroundColor = self.style.sectionHeaderBackgroundColor
        
    }
    
    // header
    fileprivate func prepareHeader(){
        _ = self.header.aZConstraints.parent(parent: self.view).top(constant: self.style.statusBarHeight).right().left().height(constant: self.style.sectionHeaderHeight)
        self.header.type = AZHeaderType.success
        self.header.delegate = self
    }
    
    // image view
    fileprivate func prepareImageView(){
        
        _ = self.imageView.aZConstraints.parent(parent: self.view).top(to: self.header, toAttribute: .bottom).left().right().height(to: self.view, multiplier: 0.45)
        self.imageView.contentMode = .scaleAspectFit
    }
    
    // collection view
    fileprivate func prepareCollectionView(){
        
        _ = self.collectionView.aZConstraints.parent(parent: self.view).top(to: self.imageView, toAttribute: .bottom).left().right().bottom(to: self.bottomBar, toAttribute: .top)
        self.collectionView.delegate = self
    }
    
    // take Photo view
    fileprivate func prepareTakePhotoView(){
        
        _ = self.takePhotoView.aZConstraints.parent(parent: self.view).top(to: self.header, toAttribute: .bottom).left().right().bottom(to: self.bottomBar, toAttribute: .top)
        self.takePhotoView.delegate = self
    }
    
    // bottom bar
    fileprivate func prepareBottomBar(){
        
        _ = self.bottomBar.aZConstraints.parent(parent: self.view).bottom().left().right().height(constant: self.style.sectionPhotoViewControllerBottomBarHeight)
        self.bottomBar.backgroundColor = self.style.sectionPhotoViewControllerBottomBarColor
        
        for v in [libraryButton, takePhotoButton, takeVideoButton] as [UIView]{
            
            v.translatesAutoresizingMaskIntoConstraints = false
            self.bottomBar.addSubview(v)
        }
        
        self.prepareLibraryButton()
        self.prepareTakePhotoButton()
        self.prepareTakeVideoButton()
        
//        self.libraryButtonAction(self.libraryButton)
        self.takePhotoButtonAction(self.takePhotoButton)
    }
    
    // library button
    fileprivate func prepareLibraryButton(){
        
        _ = self.libraryButton.aZConstraints.parent(parent: self.bottomBar).centerY().right().width(to: self.bottomBar, multiplier: 0.33)
        self.titleLibrary = self.style.sectionPhotoViewControllerTitleLibrary
        self.fontLibrary = self.style.sectionPhotoViewControllerFontLibrary
        self.libraryButton.addTarget(self, action: #selector(libraryButtonAction(_:)), for: .touchUpInside)
    }
    
    // take photo
    fileprivate func prepareTakePhotoButton(){
        
        _ = self.takePhotoButton.aZConstraints.parent(parent: self.bottomBar).centerY().right(to: self.libraryButton, toAttribute: .left).width(to: self.libraryButton)
        self.titleTakePhoto = self.style.sectionPhotoViewControllerTitleTakePhoto
        self.fontTakePhoto = self.style.sectionPhotoViewControllerFontTakePhoto
        self.takePhotoButton.addTarget(self, action: #selector(takePhotoButtonAction(_:)), for: .touchUpInside)
    }
    
    // take video
    fileprivate func prepareTakeVideoButton(){
        
        _ = self.takeVideoButton.aZConstraints.parent(parent: self.bottomBar).centerY().right(to: self.takePhotoButton, toAttribute: .left).width(to: self.libraryButton)
        self.titleTakeVideo = self.style.sectionPhotoViewControllerTitleTakeVideo
        self.fontTakeVideo = self.style.sectionPhotoViewControllerFontTakeVideo
        self.takeVideoButton.addTarget(self, action: #selector(takeVideoButtonAction(_:)), for: .touchUpInside)
    }
    
    // prepare bar button color
    fileprivate func prepareBarBottomColor(_ sender: AZButton){
        
        sender.setTitleColor(self.style.sectionPhotoViewControllerBottomBarButtonColor, for: .normal)
        sender.setTitleColor(self.style.sectionPhotoViewControllerBottomBarButtonActiveColor, for: .highlighted)
    }
    
    // prepare Show Library
    fileprivate func showLibrary(_ show: Bool = false){
        self.collectionView.isHidden = !show
        self.imageView.isHidden = !show
    }
    
    // prepare take photo
    fileprivate func showTakePhoto(_ show: Bool = false){
        self.takePhotoView.isHidden = !show
    }
    
    // prepare take video 
    fileprivate func showTakeVideo(_ show: Bool = false){
        
    }
}

// tap bar button
extension AZPhotoViewController{
    
    // reset all button
    fileprivate func resetButton(_ sender: AZButton){
        self.resetColor(sender)
        self.showLibrary(false)
        self.showTakePhoto(false)
        self.showTakeVideo(false)
    }
    
    
    // reset all color
    fileprivate func resetColor(_ sender: AZButton){
        
        self.prepareBarBottomColor(self.libraryButton)
        self.prepareBarBottomColor(self.takePhotoButton)
        self.prepareBarBottomColor(self.takeVideoButton)
        sender.setTitleColor(self.style.sectionPhotoViewControllerBottomBarButtonActiveColor, for: .normal)
    }
    
    // library
    func libraryButtonAction(_ sender: AZButton){
        self.resetButton(sender)
        self.showLibrary(true)
    }
    
    
    // take Photo
    func takePhotoButtonAction(_ sender: AZButton){
        self.resetButton(sender)
        self.showTakePhoto(true)
    }
    
    // take video
    func takeVideoButtonAction(_ sender: AZButton){
        self.resetButton(sender)
        self.showTakeVideo(true)
    }
}

// collection delegate
extension AZPhotoViewController: AZPhotoViewDelegate{
    
    func aZPhotoView(didSelected index: Int, image: AZModelPhoto) {
        
        self.imageView.image = image.image
    }
    
    func aZPhotoView(didDeselect index: Int, image: AZModelPhoto) {
        
    }
}

// take photo delegate
extension AZPhotoViewController: AZPhotoTakePhotoDelegate{

    func take(_ image: UIImage) {
        
        self.images = [image]
    }
}


// header delegate
extension AZPhotoViewController: AZPopupViewDelegate{
    
    public func cancelPopupView() {
        
        self.delegate?.cancel()
        self.dismiss(animated: true, completion: nil)
    }
    
    public func submitPopupView() {
        
        guard let image = self.images.first else {
            
            self.delegate?.submitPhoto(image: UIImage())
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.delegate?.submitPhoto(image: image)
        self.dismiss(animated: true, completion: nil)
    }
}
