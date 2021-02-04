//
//  ItemDetailView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI


struct ItemDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var password: PasswordCore = PasswordCore()
    var mail: MailCore = MailCore()
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
           titleNav =   mail.title!

        case "password":
            titleNav =   password.title!

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
      Text("pp")
    }
}

struct showDetailsMail : View {
    @Environment(\.managedObjectContext) private var viewContext

  var item: MailCore
    var ifEditMode: Bool
    @State var title = ""
    @State var mail = ""
    @State var password = ""

   

    
    var body: some View{
        
        VStack{

            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $title)
            DetailRow(label: "E-mail", ifEditMode: ifEditMode, text: $mail)
            PasswordRow(password: $password, ifEditMode: ifEditMode)

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
        .onAppear{
            title = item.title!
            mail = item.adres!
            password = item.password!
            
        }
        

    }
    
    func saveEditedItem(){
        
        item.title = title
       item.adres! = mail
      item.password! = password
        
        do {
            try viewContext.save()
            
            
       
        } catch {
       
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            print("error")
        }
        

 
   
        
    }
}

struct showDetailsPassword : View {
    @Environment(\.managedObjectContext) private var viewContext

    var item: PasswordCore
    var ifEditMode: Bool
    

    @State var title = ""
    @State var username = ""
    @State var url = ""
    @State var password = ""

   

    
    var body: some View{
        
        VStack{

            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $title)
            DetailRow(label: "Username", ifEditMode: ifEditMode, text: $username)
            DetailRow(label: "Url", ifEditMode: ifEditMode, text: $url)
            PasswordRow(password: $password, ifEditMode: ifEditMode)


     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(color: Color.purple, radius: 30 )
        .onDisappear{
            saveEditedItem()
        }
        .onAppear{
            title = item.title!
            username = item.username!
            url = item.url!
            password = item.password!
            
        }
        
        

    }
    
    func saveEditedItem(){
        
        item.title = title
       item.username! = username
      item.url! = url
      item.password! = password
        
        do {
            try viewContext.save()
            
            
       
        } catch {
       
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            print("error")
        }
        

        
    }
}


struct DetailRow: View {
    var label: String
    var ifEditMode: Bool
  @Binding   var text: String
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
      

   
        
    }
}
