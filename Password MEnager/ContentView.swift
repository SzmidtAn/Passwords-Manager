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

    
    var item = Item(title: "fef", password: "fewf")
    
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
                            }
                .navigationBarTitle("Your passwords")
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
    static var previews: some View {
        ContentView()
    }
}


struct ItemListView: View{
    var item: Item
    @State   var img = "star"


    var body: some View{
        
        NavigationLink(
            destination: Text("Item detail here")){
            
        
        HStack{
         
            Image(systemName: "key.fill")
                .rotationEffect(.degrees(-30))

        
        Text(item.title)
            
            Spacer()
            
            
          Image(systemName: img)
                .onTapGesture {
                    
                    if img == "star"{
                    // TODO add to favourite
                    img = "star.fill"
                    }else {
                        img = "star"
                    }
              
                    
                }

        }.padding()
        
    }
    }
    
}


