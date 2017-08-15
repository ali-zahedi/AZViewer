//
//  AZPhotoTakePhotoView.swift
//  AZViewer
//
//  Created by Ali Zahedi on 8/1/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation
import AVFoundation

protocol AZPhotoTakePhotoDelegate{
    
    func take(_ image: UIImage)
}

class AZPhotoTakePhotoView: AZView{
    
    // MARK: Public
    var takePhotoImage: UIImage! {
        didSet{
            self.takePhotoButton.setImage(self.takePhotoImage, for: .normal)
        }
    }
    
    var takePhotoImageTintColor: UIColor! {
        didSet{
            self.takePhotoButton.tintColor = self.takePhotoImageTintColor
        }
    }
    
    var bottomViewBackgroundColor: UIColor! {
        didSet{
            self.bottomView.backgroundColor = self.bottomViewBackgroundColor
        }
    }
//    weak var delegate: FSCameraViewDelegate? = nil
    var delegate: AZPhotoTakePhotoDelegate?
    
    // MARK: Private
    // preview
    fileprivate var videoLayer: AVCaptureVideoPreviewLayer?
    fileprivate var previewView: AZView = AZView()
    // take photo
    fileprivate var bottomView: AZView = AZView()
    fileprivate var takePhotoButton: AZButton = AZButton()
    fileprivate var imageView: AZImageView = AZImageView()
    
    // session
    fileprivate var session: AVCaptureSession!
    fileprivate var device: AVCaptureDevice!
    fileprivate var videoInput: AVCaptureDeviceInput!
    fileprivate var imageOutput: AVCaptureStillImageOutput!

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
        
        for v in [previewView, bottomView] as [UIView]{
            
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        // prepare
        self.preparePreviewView()
        self.prepareBottomView()
        self.preparepAVFundation()
    }
    
    func resetSize(){
        self.videoLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.videoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoLayer?.frame = self.previewView.frame
        self.previewView.layer.addSublayer(self.videoLayer!)
    }
}

// prepare
extension AZPhotoTakePhotoView{
    
    // preview view
    fileprivate func preparePreviewView(){
        _ = self.previewView.aZConstraints.parent(parent: self).top().left().right().height(to: self, multiplier: 0.8)
        self.previewView.backgroundColor = .black
        
    }
    
    // bottom view
    fileprivate func prepareBottomView(){
        
        _ = self.bottomView.aZConstraints.parent(parent: self).top(to: self.previewView, toAttribute: .bottom).right().left().bottom()
        self.bottomViewBackgroundColor = self.style.sectionPhotoViewControllerTakePhotoBottomViewColor
        
        for v in [imageView, takePhotoButton] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.bottomView.addSubview(v)
        }
        
        // prepare
        self.prepareTakePhotoButton()
        self.prepareImageView()
    }
    
    // take button 
    fileprivate func prepareTakePhotoButton(){
        _ = self.takePhotoButton.aZConstraints.parent(parent: self.bottomView).centerX().centerY()
        self.takePhotoImage = self.style.sectionPhotoViewControllerTakePhotoImage
        self.takePhotoImageTintColor = self.style.sectionPhotoViewControllerTakePhotoImageTintColor
        self.takePhotoButton.addTarget(self, action: #selector(takePhotoButtonAction(_:)), for: .touchUpInside)
    }
    
    // image view
    fileprivate func prepareImageView(){
        _ = self.imageView.aZConstraints.parent(parent: self.bottomView).left().centerY().height(to: self.bottomView, multiplier: 0.9).width(to: self.imageView, toAttribute: .height)
        self.imageView.contentMode = .scaleAspectFit
    }
    
    // AVFundation
    fileprivate func preparepAVFundation(){
        
        self.session = AVCaptureSession()
        
        guard let _ = self.session else { return }
        
        for device in AVCaptureDevice.devices() {
            
            if let device = device as? AVCaptureDevice,
                device.position == AVCaptureDevicePosition.back {
                
                self.device = device
                
                if !device.hasFlash {
                    
//                    flashButton.isHidden = true
                }
            }
        }
        
        do {
            
            self.videoInput = try AVCaptureDeviceInput(device: self.device)
            self.session.addInput(self.videoInput)
            
            self.imageOutput = AVCaptureStillImageOutput()
            self.session.addOutput(imageOutput)
            
            self.session.sessionPreset = AVCaptureSessionPresetPhoto
            
            self.session.startRunning()
            
            // Focus View
//            self.focusView         = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
//            let tapRecognizer      = UITapGestureRecognizer(target: self, action:#selector(FSCameraView.focus(_:)))
//            tapRecognizer.delegate = self
//            self.previewViewContainer.addGestureRecognizer(tapRecognizer)
            
        } catch {
            print("catch")
        }
        
    }
    
    
    // start camera
    fileprivate func startCamera() {
        
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
            
        case .authorized:
            
            self.session.startRunning()
            
//            motionManager = CMMotionManager()
//            motionManager!.accelerometerUpdateInterval = 0.2
//            motionManager!.startAccelerometerUpdates(to: OperationQueue()) { [unowned self] (data, _) in
//                
//                if let data = data {
//                    
//                    if abs(data.acceleration.y) < abs(data.acceleration.x) {
//                        
//                        self.currentDeviceOrientation = data.acceleration.x > 0 ? .landscapeRight : .landscapeLeft
//                        
//                    } else {
//                        
//                        self.currentDeviceOrientation = data.acceleration.y > 0 ? .portraitUpsideDown : .portrait
//                    }
//                }
//            }
            
        case .denied, .restricted:
            
            self.stopCamera()
            
        default:
            
            break
        }
    }
    
    // stop camera
    fileprivate func stopCamera() {
        
        self.session.stopRunning()
//        motionManager?.stopAccelerometerUpdates()
//        currentDeviceOrientation = nil
    }
    
    // shot
    func takePhotoButtonAction(_ sender: UIButton) {
        
        guard let imageOutput = imageOutput else {
            
            return
        }
        
        DispatchQueue.global(qos: .default).async(execute: { () -> Void in
            
            let videoConnection = imageOutput.connection(withMediaType: AVMediaTypeVideo)
            
            
            self.imageOutput.captureStillImageAsynchronously(from: videoConnection) { (buffer, error) -> Void in
                
//                self.stopCamera()
                
                guard let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer),
                    let image = UIImage(data: data)
//                    , let delegate = self.delegate
                    else {
                        
                        return
                }

                self.imageView.image = image
                self.delegate?.take(image)
//                DispatchQueue.main.async(execute: { () -> Void in
//                    
//                    let image = fusumaCropImage ? UIImage(cgImage: imageRef, scale: sw/iw, orientation: image.imageOrientation) : image
//                    
//                    delegate.cameraShotFinished(image)
//                    
//                    if fusumaSavesImage {
//                        
//                        self.saveImageToCameraRoll(image: image)
//                    }
//                    
//                    self.session       = nil
//                    self.device        = nil
//                    self.imageOutput   = nil
//                    self.motionManager = nil
//                })
            }
        })
    }
}
