//
//  FavouriteView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var savedItemsList: SavedItems

    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [  .foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .purple
        
        UITableView.appearance().backgroundColor = UIColor(Color.white.opacity(0))

    }
    
    
    
    var body: some View {
        
        NavigationView{
            
            
            ZStack{
                
                        List{
                                    ForEach(savedItemsList.PasswordsList){
                                        item in
                                        if item.isFovourite == true{
                                        PasswordListRowView(item: item)
                                            
                                        }
                                        }
                                    .onDelete(perform: { indexSet in
                                        savedItemsList.PasswordsList.remove(atOffsets: indexSet)

                                    })
                           
                                ForEach(savedItemsList.MailsList){
                                    item in
                                    if item.isFovourite == true{
                                    MailListRowView(item: item)
                                        
                                    }
                                    }
                                .onDelete(perform: { indexSet in
                                    savedItemsList.MailsList.remove(atOffsets: indexSet)
                                })
                            
                            ForEach(savedItemsList.NotesList){
                                item in
                                if item.isFovourite == true{
                                NotesListRowView(item: item)
                                    
                                }
                                }
                            .onDelete(perform: { indexSet in
                                savedItemsList.NotesList.remove(atOffsets: indexSet)
                            })
                      
                            }
                .navigationBarTitle("Favourite")
                        .navigationBarItems(trailing: EditButton())
                        .shadow(color: Color.purple, radius: 20 )
                        .listStyle(InsetGroupedListStyle())
                        .background(backgrundColor())
                        .ignoresSafeArea()

          
            }
            .ignoresSafeArea()
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
