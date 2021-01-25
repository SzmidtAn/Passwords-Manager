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
    var strengths = ["Password", "Mail"]

       @State private var selectedStrength = 0
    
    
    var body: some View {


        Form{
            
            Section {
                            Picker(selection: $selectedStrength, label: Text("Category")) {
                                ForEach(0 ..< strengths.count) {
                                    Text(self.strengths[$0])
    }
                            }
                     }
            
            
            Section{
                
                switch selectedStrength {
              
                case "Password":
                    newPassForm()
                case "Mail":
                    newMailForm()

                }
                
           
            


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
        .shadow(radius: 30 )
        .background(backgrundColor())
        .ignoresSafeArea()

    }
    

    
    func addNewItem(){
        
        if getTitle != "" && getPassword != ""{
       
            savedItemsList.PasswordsList.append(Password(title: getTitle, password: getPassword, url: getUrl, username: getUsername))
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

struct newPassForm: View {
    var body: some View{
        
        Label {TextField("Tittle", text: $getTitle)
        } icon: {Image(systemName: "plus")}
        
        Label {TextField("Username", text: $getUsername)
        } icon: {Image(systemName: "person.crop.circle")}
        
        Label {TextField("Url", text: $getUrl)
        } icon: {Image(systemName: "link")}
        
        Label {TextField("Password", text: $getPassword)
        } icon: {Image(systemName: "lock")}
    }
}

struct newMailForm: View {
    var body: some View{
        
        Label {TextField("Tittle", text: $getTitle)
        } icon: {Image(systemName: "plus")}
        
        Label {TextField("Username", text: $getUsername)
        } icon: {Image(systemName: "person.crop.circle")}
        
        Label {TextField("Url", text: $getUrl)
        } icon: {Image(systemName: "link")}
        
        Label {TextField("Password", text: $getPassword)
        } icon: {Image(systemName: "lock")}
    }
}



