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
    @State private var bankTitle = "Bank"
    @State private var cardsTyp = "VISA"
    @State private var cardsNumber = "0000 0000 0000 0000"
    @State private var cardsValid = "MM/YY"
    @State private var cardsOwner = "NAME NAME"
    @State var getChoosenColor = Color.red
    @State private var cardsColor = "red"
    @State private var showSheet = false
    @State private var showSheetCardsDetails = false

    var categoriesList = ["Password", "Mail", "Note", "Credit Card"]

       @State private var selectedStrength = 0
    
    
    var body: some View {

   
        VStack{
        Form{
            
                
                


            Section {
                            Picker(selection: $selectedStrength, label: Text("Category")) {
                                ForEach(0 ..< categoriesList.count) { i in
                                    Text(self.categoriesList[i])
                             
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
                    Text("Tap on the card and fill in")
                }

        }

            Section{
                if selectedStrength != 3 {
                NavigationLink(
                    destination: ReadFromPictureView(username: $getUsername, password: $getPassword)    ){
                    Button("Skan login details from image", action: {
                        self.showSheet.toggle()
                    }).buttonStyle(DefaultButtonStyle())
                }
                }else{
                NavigationLink(
                    destination: SkanCreditCardView(bankTitle: $bankTitle, cardsTyp: $cardsTyp, cardsNumber: $cardsNumber, cardsValid: $cardsValid, cardsOwner: $cardsOwner, cardsColor: $cardsColor)    ){
                    Button("Skan cards details", action: {
                        self.showSheetCardsDetails.toggle()
                    }).buttonStyle(DefaultButtonStyle())
                    }
                    
                }

                
            }


            Section{
                if self.showSheet{
                    PasswordGenerator(pass: self.$getPassword)
                }
                if self.showSheetCardsDetails{
                    
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
                                    case 3:
                                        self.addNewCreditCard()
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

            if selectedStrength == 3 {
                chooseColorForCardView(getChoosenColor: $getChoosenColor)
                
                VStack{
                            HStack{
                                TextField(bankTitle, text: $bankTitle)
                Spacer()
                                TextField(cardsTyp, text: $cardsTyp)
                            .font(.title)
                                    
                    }
                    .padding()
                    HStack{
                    Image("chip")
                        .resizable()
                        .frame(width: 60, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                   Spacer()
                    }
                    .padding(.leading)
                    
                    TextField(cardsNumber, text: $cardsNumber)
                        .font(.title)
                        .padding(.horizontal)
                    HStack{
                        Spacer()
                        Text("VALID\nTHRU")
                            .font(.system(size:7))
                        TextField(cardsValid, text: $cardsValid)
                        Spacer()

                    }
                    .padding(1.0)
                    HStack{
                        TextField(cardsOwner, text: $cardsOwner)
                    Spacer()
                    }
                    .padding([ .leading, .bottom])
                    
                    Spacer()

                }
                .frame(width: 350, height: 220, alignment: .center)
                .background(LinearGradient(gradient: Gradient(colors: [getChoosenColor, getChoosenColor]), startPoint: .top, endPoint: .leading))
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                .shadow(color: getChoosenColor.opacity(0.8) , radius: 10   , x: 10, y:10 )
            

            }

        }
        .offset(y: -100)
        Spacer()

    }
    
    func getColorFromUser() {
        
        switch getChoosenColor {
        case Color.red:
            self.cardsColor = "red"
        case Color.orange:
            self.cardsColor = "orange"
        case Color.blue:
            self.cardsColor = "blue"
        case Color.green:
            self.cardsColor = "green"
        case Color.gray:
            self.cardsColor = "gray"
        default:
            self.cardsColor = "red"
        }
        
        
        
    }
    
    
    func addNewCreditCard(){
        
        getColorFromUser()
       
            
            let newCreditCard = CreditCardCore(context: viewContext)
        newCreditCard.bankTitle = bankTitle
        newCreditCard.cardsTyp = cardsTyp
        newCreditCard.cardsNumber = cardsNumber
        newCreditCard.cardsValid = cardsValid
        newCreditCard.cardsOwner = cardsOwner
        newCreditCard.cardsColor = cardsColor
        
            newCreditCard.id = UUID()
            
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
       
            
            let newNote = NoteCore(context: viewContext)
            newNote.title = getTitle
            newNote.note = getUsername
     
            newNote.id = UUID()
            
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
    
    
    
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView()
    }
}

struct chooseColorForCardView: View {
    @Binding  var getChoosenColor: Color
    
    var body: some View{
        
        HStack{
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.red)
                .onTapGesture {
                    getChoosenColor = Color.red
                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.orange)
                .onTapGesture {
                    getChoosenColor = Color.orange
                }
       
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.green)
                .onTapGesture {
                    getChoosenColor = Color.green
                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.blue)
                .onTapGesture {
                    getChoosenColor = Color.blue
                }
        
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    getChoosenColor = Color.gray
                }
        
        }
        
        
    }
}
