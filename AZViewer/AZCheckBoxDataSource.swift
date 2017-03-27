//
//  AZCheckBoxDataSource.swift
//  Pods
//
//  Created by Ali Zahedi on 1/5/1396 AP.
//
//

import Foundation

open class AZCheckBoxDataSource {
    
    public var id: AnyObject
    public var title: String
    public var isActive: Bool
    
    public init(id: AnyObject, title: String, isActive: Bool = false) {
        self.id = id
        self.title = title
        self.isActive = isActive
    }
}

open class AZCheckBoxDataSection {

    public var value: [AZCheckBoxDataSource]
    
    public init() {
        self.value = []
    }
    
    public init(value: [AZCheckBoxDataSource]) {
        
        self.value = value
    }
}

// ["section1": [AZCheckBoxDataSource, AZCheckBoxDataSource]
//var data: [String: [AZCheckBoxDataSource]]
