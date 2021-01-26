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
    @State var ifCategory = true


    
    var body: some View {
        
        NavigationView{
            
            ZStack{
            backgrundColor()

                if ifCategory{
                showDetailsPassword(item: password)
                } else {
                    showDetailsMail(item: mail)
                }
                
    
            }
            .ignoresSafeArea()

        }
        .navigationBarTitle(password.title, displayMode: .inline)
        
        }
    
    }


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(password: Password(title: "Facebook", password: "edsfw332"), mail: Mails(title: "dfe", adress: "de", password: "dw3d"))
    }
}

struct showDetailsMail : View {
    var item: Mails

    
    var body: some View{
        
        VStack{

            DetaiRow(label: "Title", text: item.title)
            DetaiRow(label: "E-mail", text: item.adress)
            PasswordRow(item: item.password)


     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
        

    }
}

struct showDetailsPassword : View {
    var item: Password

    
    var body: some View{
        
        VStack{

            DetaiRow(label: "Title", text: item.title)
            DetaiRow(label: "Username", text: item.username)
            DetaiRow(label: "Url", text: item.url)
            PasswordRow(item: item.password)


     
        }
        .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(radius: 30 )
        

    }
}


struct DetaiRow: View {
    var label: String
    var text: String
    var body: some View{
        
        HStack{
            Text(label)
                .bold()
            
            Text(text)
            
            Image(systemName: "doc.on.doc")
                .onTapGesture {
             
                }

            Spacer()
        }
        .padding([.leading, .top, .trailing])
        
    }
}


struct PasswordRow: View {
    var item: String

    @State private var password = ""
    @State private var showPassword = false
    var body: some View{
        HStack{
            
            Text("Password")
                .bold()
            
            if showPassword {

                                Text(password)
                                    .frame(width: 150.0)


                            } else {
                            SecureField("Password",
                                      text: $password)

                                .frame(width: 150.0)
                            }


            Image(systemName: "eye")
                .onTapGesture {
                    if showPassword == false{
                    showPassword = true
                    }else{
                        showPassword = false
                    }
                }

            
            Spacer()


        
        }
        .onAppear(){
            password = item
        }
        .padding([.leading, .bottom, .top, .trailing])
    }
}
