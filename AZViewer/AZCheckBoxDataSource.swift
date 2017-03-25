//
//  AZCheckBoxDataSource.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

class AZCheckBoxDataSource {
    
    var id: AnyObject
    var title: String
    var isActive: Bool
    
    init(id: AnyObject, title: String, isActive: Bool = false) {
        self.id = id
        self.title = title
        self.isActive = isActive
    }
}

class AZCheckBoxDataSection {

    var value: [AZCheckBoxDataSource]
    
    init() {
        self.value = []
    }
    
    init(value: [AZCheckBoxDataSource]) {
        
        self.value = value
    }
}

// ["section1": [AZCheckBoxDataSource, AZCheckBoxDataSource]
//var data: [String: [AZCheckBoxDataSource]]
