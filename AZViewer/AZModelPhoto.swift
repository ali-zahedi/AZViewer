//
//  AZModelPhoto.swift
//  AZViewer
//
//  Created by Ali Zahedi on 7/22/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation
import Photos

public class AZModelPhoto {
    
    // MARK: public
    public var image: UIImage!
    public var selected: Bool = false
    // MARK: Private
    
    
    // MARK: Init
    init(image: UIImage) {
        
        self.image = image
    }
}
