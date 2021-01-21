//
//  SavedItems.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI


class SavedItems : ObservableObject{
    
    @Published var items = [Item]()
    
    
    func add (item: Item){
        items.append(item)
    }
    

    
}


