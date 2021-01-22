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
    @State private var getPassword = ""
    @State private var length = 9

    
    var body: some View {


        Form{
            
            
            Section{
                
                TextField("Tittle", text: $getTitle)
                TextField("Password", text: $getPassword)

                Button("Password generator", action: {
                    autoPasswordGenerator()
                          }).buttonStyle(DefaultButtonStyle())
                
                
            }
            
            
            Section{
                
                Stepper("How many characters: \(length)", value: $length, in: 3...20)

                
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
    
    func autoPasswordGenerator(){
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let pass =   String((0..<length).map{ _ in letters.randomElement()! })
        
        
        getPassword = pass
        
        
    }
    
    
    func addNewItem(){
        
        if getTitle != "" && getPassword != ""{
       
         savedItemsList.items.append(Item(title: getTitle, password: getPassword))
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



