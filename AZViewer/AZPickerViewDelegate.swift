//
//  AZPickerViewDelegate.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/6/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public protocol AZPickerViewDelegate {
    func aZPickerView(didSelectRow row: Int, inComponent component: Int)
}
