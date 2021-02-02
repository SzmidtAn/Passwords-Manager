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
    @State private var getUrl = ""
    @State private var getUsername = ""

    @State private var showSheet = false
    var categoriesList = ["Password", "Mail", "Note"]

       @State private var selectedStrength = 0
    
    
    var body: some View {

   

        Form{
            
                
                


            Section {
                            Picker(selection: $selectedStrength, label: Text("Category")) {
                                ForEach(0 ..< categoriesList.count) {
                                    Text(self.categoriesList[$0])
    }
                            }
                     }

//
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
                    
                    
                    Button("Password generator", action: {
                        self.showSheet.toggle()
                    }).buttonStyle(DefaultButtonStyle())
                    
                    
                case 1:

                    Label {TextField("Tittle", text: $getTitle)
                    } icon: {Image(systemName: "plus")}

                    Label {TextField("E-mail", text: $getUsername)
                    } icon: {Image(systemName: "envelope")}


                    Label {TextField("Password", text: $getPassword)
                    } icon: {Image(systemName: "lock")}

                    
                    
                    Button("Password generator", action: {
                        self.showSheet.toggle()
                    }).buttonStyle(DefaultButtonStyle())
                    

                case 2:

                    Label {TextField("Tittle", text: $getTitle)
                    } icon: {Image(systemName: "plus")}

              


                    Label {TextEditor( text: $getUsername)
                    } icon: {Image(systemName: "note.text")}


                    
                    
                default:
                    Text("Choose category")
                }
//
//
//
//

//
//
//
        }
//
//
            Section{
                NavigationLink(
                    destination: ReadFromPictureView(username: $getUsername, password: $getPassword)    ){

                    Button("Skan login details from picture", action: {
                        self.showSheet.toggle()
                    }).buttonStyle(DefaultButtonStyle())


                }

            }


            Section{
                if self.showSheet{
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
                                    case 2:
                                        self.addNewNote()
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
    
    func addNewNote(){
        
        if getTitle != "" && getUsername != ""{
       
            savedItemsList.NotesList.append(Notes(title: getTitle, note: getUsername))
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

