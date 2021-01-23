//
//  AddNewItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct AddNewItemView: View {
    @EnvironmentObject var savedItemsList: SavedItems
    @Environment(\.presentationMode) var presentation
    
    @State private var getTitle = ""
    @State  var getPassword: String = ""
    var pass:String = ""
    @State private var getUrl = ""
    @State private var getUsername = ""

    @State private var showSheet = false

    
    var body: some View {


        Form{
            
            
            Section{
                
                
                TextField("Tittle", text: $getTitle)
                TextField("Username", text: $getUsername)
                TextField("Url", text: $getUrl)
                TextField("Password", text: $getPassword)


                Button("Password generator", action: {

                    self.showSheet.toggle()
                }).buttonStyle(DefaultButtonStyle())
                .sheet(isPresented: $showSheet){
                    PasswordGenerator(pass: self.$getPassword)
                }
                
                
            }
            
      
            
            
            
           
        }
        .navigationBarTitle("Add a new password", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                    self.addNewItem()
                  } )
        {
                 Text("Done")
                                } )
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)

    }
    

    
    func addNewItem(){
        
        if getTitle != "" && getPassword != ""{
       
            savedItemsList.items.append(Item(title: getTitle, password: getPassword, url: getUrl, username: getUsername))
        self.presentation.wrappedValue.dismiss()
        }else {
        }
        }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView()
    }
}



