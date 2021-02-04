//
//  AddNewItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI
import CoreData

struct AddNewItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PasswordCore.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PasswordCore>
    

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
                            .pickerStyle(SegmentedPickerStyle())
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
        .shadow(color: Color.purple, radius: 20 )
        .background(backgrundColor())
        .ignoresSafeArea()

    }
    

    func addNewMail(){
        
        
        if getTitle != "" && getPassword != ""{
       
            
            let newPassword = MailCore(context: viewContext)
            newPassword.title = getTitle
            newPassword.adres = getUsername
            newPassword.password = getPassword
            newPassword.id = UUID()
            
            do {
                try viewContext.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                print("error")
            }
            
        self.presentation.wrappedValue.dismiss()
        }else {
        }
        
        }
    
    func addNewPassword(){
        
        
        if getTitle != "" && getPassword != ""{
       
            
            let newPassword = PasswordCore(context: viewContext)
            newPassword.title = getTitle
            newPassword.username = getUsername
            newPassword.url = getUrl
            newPassword.password = getPassword
            newPassword.id = UUID()
            
            do {
                try viewContext.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                print("error")
            }
            
        self.presentation.wrappedValue.dismiss()
        }else {
        }
        
        
    
        
        
        }
    
    func addNewNote(){
        
        if getTitle != "" && getUsername != ""{
       
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

