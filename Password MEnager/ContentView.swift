//
//  ContentView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var savedItemsList: SavedItems

    @State private var paymentType = 0
    static let paymentTypes = ["Cash", "CredicCard", "iDinePoints"]

    
    
    func remove(at offsets: IndexSet){

        
        savedItemsList.items.remove(atOffsets: offsets)
    }
    
    
    
    var body: some View {
        
        NavigationView{
            
            
            ZStack{
                        List{
                                Section{
                                    ForEach(savedItemsList.items){
                                        item in
                                        ItemListView(item: item)
                                    }.onDelete(perform: remove(at:))
                                    
                                    
                
                                }
                            
                            Section{
                                ForEach(savedItemsList.items){
                                    item in
                                    ItemListView(item: item)
                                }.onDelete(perform: remove(at:))
            
                            }
                            
                            
                            }


                .navigationBarTitle("Accounts")
                        .navigationBarItems(trailing: EditButton())
                            .listStyle(GroupedListStyle())

                HStack{
                    
                    Spacer(    )
                    VStack{
                    
                Spacer(     )
                
                NavigationLink(
                    destination: AddNewItemView()    ){
                    
                Image(systemName: "plus.circle")
                .resizable()
                    .frame(width: 50, height: 50)
                .clipShape(Circle())
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 20)
                
                }
       

                }
                .padding()
                

                
                }.zIndex(3.0)

            }

        }

    
    
    }
    
}


struct ContentView_Previews: PreviewProvider {

    
    static let modelData = SavedItems()

    static var previews: some View {
        ContentView()
            .environmentObject(modelData)

    }
}


struct ItemListView: View{
    @EnvironmentObject var savedItemsList: SavedItems
    @State   var img = "star"

    var item: Item
  
    
    

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(item: item)){
            
            
        
        HStack{
         
            Image(systemName: "key.fill")
                .rotationEffect(.degrees(-30))

        
        Text(item.title)
            
            Spacer()
            
            
          Image(systemName: img)
            .foregroundColor(.yellow)
                .onTapGesture {
                    
                    let index = savedItemsList.items.firstIndex { i -> Bool in
                        i.id == self.item.id
                    }
                 
                    if img == "star"{

                        savedItemsList.items[index!].isFovourite = true
                        img = "star.fill"
                    }else {
                     img = "star"
                        savedItemsList.items[index!].isFovourite = false
                    }
              
                    
                }

        }
      
        
        }
   
        .onAppear(){

       
            
            let index = savedItemsList.items.firstIndex { i -> Bool in
                i.id == self.item.id
            }

            if index != nil {


            if            savedItemsList.items[index!].isFovourite{
                img = "star.fill"
            }else{
                img = "star"
            }
            }
        }
        
    }
    
    
    
}


