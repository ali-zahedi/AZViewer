//
//  AZAlignment.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/26/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public enum AZHorizontalAlignment {
    case right
    case middle
    case left
    
    func attribute() -> NSLayoutAttribute{
        switch self {
        case .right:
            return .right
        case .left:
            return .left
        case .middle:
            return .centerX
        }
    }
}

public enum AZVerticalAlignment {
    case top
    case middle
    case bottom
    
    func attribute() -> NSLayoutAttribute{
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .middle:
            return .centerY
        }
    }
}
