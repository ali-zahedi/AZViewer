//
//  String.swift
//  AZViewer
//
//  Created by Ali Zahedi on 8/29/17.
//  Copyright © 2017 Ali Zahedi. All rights reserved.
//

import Foundation

extension String {
    public func ltr() -> String {
        return "\u{200E}".appending(self)
    }
    
    public func rtl() -> String {
        return "\u{200F}".appending(self)
    }
}
