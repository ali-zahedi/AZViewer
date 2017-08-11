//
//  AZPhotoViewDelegate.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/22/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol AZPhotoViewDelegate {
    func aZPhotoView(didSelected index: Int, image: AZModelPhoto)
    func aZPhotoView(didDeselect index: Int, image: AZModelPhoto)
}
