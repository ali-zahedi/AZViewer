//
//  AZPhotoCollectionView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/22/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import UIKit
import Photos

class AZPhotoCollectionView: AZView {
    
    // MARK: Public
    
    // MARK: Internal
    static var spacing: CGFloat{
        return  CGFloat(1)
    }
    var delegate: AZPhotoViewDelegate?
    var objects: [AZModelPhoto] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Private
    fileprivate var hasGalleryPermission: Bool {
        
        PHPhotoLibrary.requestAuthorization { (status) in
            // done
            if status != PHAuthorizationStatus.authorized{
                // TODO: redirect to access to the photo
                
            }
        }
        return PHPhotoLibrary.authorizationStatus() == .authorized
    }
    fileprivate var offsetIndex: Int = 0
    fileprivate var limitIndex: Int = 10
    fileprivate var collectionView: AZCollectionView = AZCollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate var collectionViewLayout: UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: AZPhotoCollectionView.spacing, left: AZPhotoCollectionView.spacing, bottom: 0, right: AZPhotoCollectionView.spacing)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = AZPhotoCollectionView.spacing
        
        layout.scrollDirection = .vertical
        return layout
    }
    
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
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AZPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        _ = self.collectionView.aZConstraints.parent(parent: self).right().left().bottom().top()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.retrievePhotos()
    }
}


extension AZPhotoCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AZPhotoCollectionViewCell
        cell.object = self.objects[indexPath.row]
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }
    
    @objc(collectionView:willDisplayCell:forItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.objects.count - 1 {
            
            self.retrievePhotos(true)
        }
        //        self.delegate?.productCollectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
}

extension AZPhotoCollectionView: UICollectionViewDelegate{
    
    // selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.retriveFile(type: .image, size: UIScreen.main.bounds.size, index: indexPath.item , completionHandler: { (image) in
        
            self.delegate?.aZPhotoView(didSelected: indexPath.item, image: AZModelPhoto(image: image))
        })
        
        let cell = collectionView.cellForItem(at: indexPath) as! AZPhotoCollectionViewCell
        cell.selected()
    }
    
}

extension AZPhotoCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return AZPhotoCollectionViewCell.size
    }
}

// load image
extension AZPhotoCollectionView{
    
    // retrive all images
    func retrievePhotos(_ retriveContinue: Bool = false){
        
        if (!self.hasGalleryPermission){
            
            return
        }
        
        if retriveContinue {
            
            self.offsetIndex = self.offsetIndex + self.limitIndex
        }else{
            
            self.offsetIndex = 0
            self.objects = []
        }
        
        
        self.retriveFile(type: .image, rangeImageIndex: self.offsetIndex...(self.limitIndex + self.offsetIndex) , completionHandler:{_ in
            // nothing
        })
    }
    
    // retrive file
    fileprivate func retriveFile(type: PHAssetMediaType = .image, size: CGSize = AZPhotoCollectionViewCell.size, index: Int? = nil, rangeImageIndex: CountableClosedRange<Int>? = nil, completionHandler: @escaping ((_ image: UIImage) -> ())){
        
        /* Retrieve the items in order of modification date, ascending */
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                    ascending: false)]
        /* Then get an object of type PHFetchResult that will contain
         all our image assets */
        let assetResults = PHAsset.fetchAssets(with: type, options: options)
        /* Get the image */
        if assetResults.count == 0 {
            
            return
        }
        
        // TODO: Retrive video
        
        // get one
        func get(i: Int, completionHandler: @escaping ((_ image: UIImage) -> ())){
            let object: AnyObject = assetResults[i]
            if let asset = object as? PHAsset{
                self.requestFile(asset: asset, size: size, completionHandler: { image in
                    completionHandler(image)
                })
                
            }
        }
        
        if let i = index{
            
            get(i: i, completionHandler: { (image) in
                
                completionHandler(image)
            })
        }else{
            
            // Retrive all
            var range: CountableClosedRange<Int> = rangeImageIndex ?? 0...(assetResults.count - 1)
            
            if range.upperBound > (assetResults.count - 1) {
                
                // check max range
                if self.objects.count == assetResults.count || range.lowerBound > (assetResults.count - 1){
                    
                    return
                }
                
                range = range.lowerBound...(assetResults.count - 1)
            }
            
            for i in range{
                
                get(i: i, completionHandler: { (image) in
                    
                    self.objects.append(AZModelPhoto(image: image))
                    completionHandler(image)
                })
            }
        }
        
    }
    
    // request for PHImage
    fileprivate func requestFile(asset: PHAsset, size: CGSize, completionHandler: @escaping ((_ image: UIImage) -> ())){
        
        /* We want to be able to display a image even if it currently
         resides only on the cloud and not on the device */
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.version = .current
        
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: { (image, c) in
            completionHandler(image!)
        })
        
    }
}
