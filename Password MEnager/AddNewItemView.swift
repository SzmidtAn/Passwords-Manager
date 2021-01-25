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
              
                case 0:
                    
                    Label {TextField("Tittle", text: $getTitle)
                    } icon: {Image(systemName: "plus")}
                    
                    Label {TextField("Username", text: $getUsername)
                    } icon: {Image(systemName: "person.crop.circle")}
                    
                    Label {TextField("Url", text: $getUrl)
                    } icon: {Image(systemName: "link")}
                    
                    Label {TextField("Password", text: $getPassword)
                    } icon: {Image(systemName: "lock")}
                case 1:
                    
                    Label {TextField("Tittle", text: $getTitle)
                    } icon: {Image(systemName: "plus")}
                    
                    Label {TextField("E-mail", text: $getUsername)
                    } icon: {Image(systemName: "envelope")}
             
                    
                    Label {TextField("Password", text: $getPassword)
                    } icon: {Image(systemName: "lock")}


                default:
                    Text("Choose category")
                }
                
           
            


                Button("Password generator", action: {
                    self.showSheet.toggle()
                }).buttonStyle(DefaultButtonStyle())
                .sheet(isPresented: $showSheet){
                    PasswordGenerator(pass: self.$getPassword)
                }
                
                
            }
            
       
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Add a new password", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    switch selectedStrength{
                                    case 0:
                                        self.addNewPassword()

                                    case 1:
                                        self.addNewMail()
                                    default:
                       break
                       }
                  } )
        {
                 Text("Done")
                                } )
        .shadow(radius: 30 )
        .background(backgrundColor())
        .ignoresSafeArea()

    }
    

    func addNewMail(){
        
        if getTitle != "" && getPassword != ""{
       
            savedItemsList.MailsList.append(Mails(title: getTitle, adress: getUsername, password: getPassword))
        self.presentation.wrappedValue.dismiss()
        }else {
        }
        }
    
    func addNewPassword(){
        
        
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

