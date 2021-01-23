//
//  FavouriteView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var savedItemsList: SavedItems

    
    
    
    
    var body: some View {
        
        NavigationView{
            
            
            ZStack{
                        List{
                                Section{
                                    ForEach(savedItemsList.items){
                                        item in
                                        if item.isFovourite == true{
                                        ItemListView(item: item)
                                            
                                        }
                                        }
                                    .onDelete(perform: { indexSet in
                                        savedItemsList.items.remove(atOffsets: indexSet)

                                    })
                
                                }
                            }
                .navigationBarTitle("Favourite")
                        .navigationBarItems(trailing: EditButton())
                        
                            .listStyle(GroupedListStyle())

          
            }
        }
      
    }
        
    
}

struct FavouriteView_Previews: PreviewProvider {
    
    static let modelData = SavedItems()

    static var previews: some View {
        FavouriteView()
            .environmentObject(modelData)

    }
}
