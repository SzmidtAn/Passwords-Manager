//
//  ItemDetailView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-22.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item


    
    var body: some View {
        
        NavigationView{
            
        
        VStack{
            DetaiRow(label: "Title", text: item.title)
            DetaiRow(label: "Username", text: item.username)
            DetaiRow(label: "Url", text: item.url)
            PasswordRow(item: item)

            Spacer()

     
        }
  
    


        }
        .navigationBarTitle(item.title, displayMode: .inline)
        
        }
    
    }


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item(title: "Facebook", password: "edsfw332"))
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

            Spacer()
        }
        .padding([.leading, .bottom, .trailing])
        
    }
}


struct PasswordRow: View {
    var item: Item

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
            password = item.password
        }
        .padding([.leading, .bottom, .trailing])
    }
}
