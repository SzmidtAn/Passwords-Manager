//
//  SavedItems.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI


class SavedItems : ObservableObject{
    
    @Published var items = [Item]()
    
    init() {
        items.append(Item(title: "Facebook", password: "dfewfd43"))
        items.append(Item(title: "Twitter", password: "dfewfd43"))
        items.append(Item(title: "Gmail", password: "dfewfd43", isFovourite: true))
        items.append(Item( title: "dew", password: "ded", isFovourite: true))
        items.append(Item(title: "Instagram", password: "dfewfd43"))
        items.append(Item(title: "Facebook", password: "dfewfd43"))
        items.append(Item(title: "Hotmail", password: "dfewfd43", isFovourite: true))
        items.append(Item(title: "Facebook", password: "dfewfd43"))

    }
    
    func add (item: Item){
        items.append(item)
    }
    

    
}


