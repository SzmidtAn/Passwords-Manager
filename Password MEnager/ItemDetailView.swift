//
//  ItemDetailView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI


struct ItemDetailView: View {
    var password: Password = Password(title: "", password: "")
    var mail: Mails = Mails(title: "", adress: "", password: "")
    var note: Notes = Notes(title: "", note: "")
   @State var titleNav = ""

    @State var ifCategory: String
    @State var ifEditMode = false



    
    var body: some View {
        
        NavigationView{
            
            ZStack{
            backgrundColor()

                switch(ifCategory){
                case "mail":
                    showDetailsMail(item: mail, ifEditMode: ifEditMode)

                case "password":
                    showDetailsPassword(item: password, ifEditMode: ifEditMode)

                case "note":
                    showDetailsNotes(item: note, ifEditMode: ifEditMode)
                default :
                Text("text")
                
                }
                
            
    
            }
            .ignoresSafeArea()

        }
        .navigationBarTitle(titleNav, displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                             EditItemButton()
                  } ){
                 Text("Edit item")    } )
        .onAppear{
            getNavTitle()
        }
      
        
        
        
        }
    
    func getNavTitle(){

        switch(ifCategory){
        case "mail":
           titleNav =   mail.title

        case "password":
            titleNav =   password.title

        case "note":
            titleNav =  note.title
        default :
        Text("text")
        
        }
            
    }
    
    func EditItemButton() {
        self.ifEditMode.toggle()
    }
    
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(password: Password(title: "Facebook", password: "edsfw332"), mail: Mails(title: "dfe", adress: "de", password: "dw3d"), ifCategory: "")
    }
}

struct showDetailsMail : View {
    @EnvironmentObject var savedItemsList: SavedItems

    @State var item: Mails
    var ifEditMode: Bool


    
    var body: some View{
        
        VStack{

            
            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $item.title)
            DetailRow(label: "E-mail", ifEditMode: ifEditMode, text: $item.adress)
            PasswordRow(password: $item.password, ifEditMode: ifEditMode)
            

     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(color: Color.purple, radius: 15 )
        .onDisappear{
            saveEditedItem()
        }
        

    }
    
    func saveEditedItem(){
      
        let index = savedItemsList.MailsList.firstIndex { i -> Bool in
            i.id == self.item.id
        }!
        
        print(savedItemsList.MailsList[index])
        print(item.title)
        
        savedItemsList.MailsList[index].title = item.title
        savedItemsList.MailsList[index].adress = item.adress
        savedItemsList.MailsList[index].password = item.password


   
        
    }
}

struct showDetailsPassword : View {
    @State var item: Password
    var ifEditMode: Bool
    
    @EnvironmentObject var savedItemsList: SavedItems



    
    var body: some View{
        
        VStack{

            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $item.title)
            DetailRow(label: "Username", ifEditMode: ifEditMode, text: $item.username)
            DetailRow(label: "Url", ifEditMode: ifEditMode, text: $item.url)
            PasswordRow(password: $item.password, ifEditMode: ifEditMode)


     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(radius: 30 )
        .onDisappear{
            saveEditedItem()
        }
        

    }
    
    func saveEditedItem(){
      
        let index = savedItemsList.PasswordsList.firstIndex { i -> Bool in
            i.id == self.item.id
        }!
        
    
        
        savedItemsList.PasswordsList[index].title = item.title
        savedItemsList.PasswordsList[index].url = item.url
        savedItemsList.PasswordsList[index].username = item.username
        savedItemsList.PasswordsList[index].password = item.password


   
        
    }
}


struct DetailRow: View {
    var label: String
    var ifEditMode: Bool
    @Binding var text: String
    var body: some View{
        
        HStack{
            Text(label)
                .bold()
            
            if ifEditMode{
            TextField(text, text: $text)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }else{
                Text(text)

            }
                
                
                Spacer()

            Image(systemName: "doc.on.doc")
                .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    UIPasteboard.general.string = text

                }

        }
        .padding([.leading, .top, .trailing])
     
        
    }
    
 
}


struct PasswordRow: View {

    @Binding  var password: String
    @State  var showPassword = false
    var ifEditMode: Bool

    
    
    var body: some View{
        HStack{
            
            Text("Password")
                .bold()
        
         
            
            if ifEditMode{
                TextField(password, text: $password)

                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }else{
                if showPassword {

                    Text(password)
                                        .frame(width: 150.0)
                                } else {
                                SecureField("Password",
                                            text: $password)

                                    .frame(width: 150.0)
                                    
                                }
            }
                

            Spacer()

            Image(systemName: "eye")
                .onTapGesture {
                    if showPassword == false{
                    showPassword = true
                    }else{
                        showPassword = false
                    }
                }
            
            Image(systemName: "doc.on.doc")
                .frame(width: 10, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    UIPasteboard.general.string = password

                }
    
        }
      
        .padding([.leading, .bottom, .top, .trailing])
    }
}

struct showDetailsNotes : View {
    @EnvironmentObject var savedItemsList: SavedItems

    @State var item: Notes
    var ifEditMode: Bool


    
    var body: some View{
        
        VStack{

            
            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $item.title)
            DetailRow(label: "Note", ifEditMode: ifEditMode, text: $item.note)
            

     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
        .onDisappear{
            saveEditedItem()
        }
        

    }
    
    func saveEditedItem(){
      
        let index = savedItemsList.NotesList.firstIndex { i -> Bool in
            i.id == self.item.id
        }!
        
        print(savedItemsList.NotesList[index])
        print(item.title)
        
        savedItemsList.NotesList[index].title = item.title
        savedItemsList.NotesList[index].note = item.note


   
        
    }
}
