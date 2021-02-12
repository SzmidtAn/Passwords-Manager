//
//  ItemDetailView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI
import UIKit

struct ItemDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var password: PasswordCore = PasswordCore()
    var mail: MailCore = MailCore()
    var note: NoteCore = NoteCore()
    @State var weeks = 8
   @State var titleNav = ""
    @State var item: String = ""

    @State var ifCategory: String
    @State var ifEditMode = false
    @State private var isShareViewPresented: Bool = false
    @State private var isScheduleViewPresented: Bool = false



    
    var body: some View {
        
        NavigationView{
            
            ZStack{
            backgrundColor()

                VStack{
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
                
                    Button("Schedule passwords change") {
                        self.isScheduleViewPresented.toggle()
                    }
                    
                    if isScheduleViewPresented{
                        showChangePasswordView(weeks: $weeks, isScheduleViewPresented: $isScheduleViewPresented, titleNav: titleNav)
                    }
                }
    
            }
            .ignoresSafeArea()

        }
        .navigationBarTitle(titleNav, displayMode: .inline)
        .navigationBarItems(trailing:
                                
                                HStack{
                                    Button(action: {
                                        isShareViewPresented.toggle()
                      } ){
                                      Image(systemName: "square.and.arrow.up")   }
                                    
                                    
                                    Button(action: {
                                 EditItemButton()
                      } ){
                     Image(systemName: "square.and.pencil") }
                                }
                                )
                             
        .onAppear{
            getNavTitle()
        }
        .sheet(isPresented: $isShareViewPresented, onDismiss: {
                  print("Dismiss")
              }, content: {
                  ActivityViewController(itemsToShare: [item])
              })

        
        
        
        }
    


    
    func getNavTitle(){

        switch(ifCategory){
        case "mail":
           titleNav =   mail.title!
            item = "\(mail.title!) Username: \(mail.adres!) Password: \(mail.password!)"

        case "password":
            titleNav =   password.title!
            item = "\(password.title!) \(String(describing: password.url)) Username: \(password.username!) Password: \(password.password!)"

        case "note":
            titleNav =  note.title!
            item = "\(note.title!) Note: \(note.note!)"

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
        .shadow(color: Color.purple.opacity(0.5) , radius: 10    , x: 10, y: 10)
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
        .shadow(color: Color.purple.opacity(0.5) , radius: 10    , x: 10, y: 10)
        
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

     var item: NoteCore
    var ifEditMode: Bool
    @Environment(\.managedObjectContext) private var viewContext
    

    @State var title = ""
    @State var note = ""

   

    
    var body: some View{
        
        VStack{

            
            DetailRow(label: "Title", ifEditMode: ifEditMode, text: $title)
            DetailRow(label: "Note", ifEditMode: ifEditMode, text: $note)
            

     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(color: Color.purple.opacity(0.5) , radius: 10    , x: 10, y: 10)
        .onDisappear{
            saveEditedItem()
        }
        .onAppear{
            title = item.title!
            note = item.note!
            
        }

    }
    
    func saveEditedItem(){
        
        item.title = title
      item.note! = note
        
        do {
            try viewContext.save()
            
            
       
        } catch {
       
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            print("error")
        }
        

        
    }
}


struct ActivityViewController: UIViewControllerRepresentable {

    var itemsToShare: [Any]
    var servicesToShareItem: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: servicesToShareItem)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}


struct showChangePasswordView: View {
    
    @Binding var weeks: Int
    @Binding var isScheduleViewPresented: Bool
    let titleNav: String
    var body: some View{
        VStack{
            Stepper("Change password after \(weeks) weeks", value: $weeks, in: 1...104)
         
            Button("Done") {
         showPushNotification()
                self.isScheduleViewPresented.toggle()
            }
        }
        .padding()
    }
    
    func showPushNotification(){
        let content = UNMutableNotificationContent()
        content.title = "It's time to change password!"
        content.subtitle = "\(titleNav) hasn't changeed the password for \(weeks) "
        content.sound = UNNotificationSound.default
        
        let waitTime = weeks * 86400 * 7
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(waitTime), repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
