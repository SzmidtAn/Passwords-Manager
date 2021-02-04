//
//  FavouriteView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI

struct FavouriteView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PasswordCore.title, ascending: true)],
        animation: .default)
    private var passwordsList: FetchedResults<PasswordCore>

    @FetchRequest(
        
        sortDescriptors: [NSSortDescriptor(keyPath: \MailCore.title, ascending: true)],
        animation: .default)
    private var MailsList: FetchedResults<MailCore>



    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [  .foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .purple
        
        UITableView.appearance().backgroundColor = UIColor(Color.white.opacity(0))

    }
    
    
    
    var body: some View {

        NavigationView{


            ZStack{
                List{
               
                            ForEach(passwordsList){
                                item in
                                if item.isFavourite == true {
                                PasswordListRowView(item: item)
                                }
                                    
                        
                    
                            }
                            .onDelete(perform: { indexSet in
                                withAnimation {
                                    indexSet.map { passwordsList[$0] }.forEach(viewContext.delete)

                                    do {
                                        try viewContext.save()
                              
                                    } catch {
                                     
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                            })
                      
      
                    


               
                        ForEach(MailsList){
                            item in
                            if item.isFavourite == true{
                            MailListRowView(item: item)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            withAnimation {
                                indexSet.map { MailsList[$0] }.forEach(viewContext.delete)

                                do {
                                    try viewContext.save()
                          
                                } catch {
                                 
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                            
                        })
       

//                    ForEach(savedItemsList.NotesList){
//                                item in
//                                NotesListRowView(item: item)
//
//
//                            }
//                            .onDelete(perform: { indexSet in
//                                savedItemsList.PasswordsList.remove(atOffsets: indexSet)
//                            })
//
//
//
//
                    
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
    

    static var previews: some View {
        FavouriteView()

    }
}
