//
//  Item.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import Foundation

struct Item: Identifiable {
    var id = UUID()
    
    var title: String
    var password: String
    
}
