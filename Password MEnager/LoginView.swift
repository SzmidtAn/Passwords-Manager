//
//  LoginView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-26.
//

import LocalAuthentication
import SwiftUI

struct LoginView: View {
    
    @State private var isUnlocked = false
    @State private var username = ""
    @State private var password = ""

    
    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [  .foregroundColor: UIColor.white]

      
    }
    
    
    
    var body: some View {
        
        NavigationView{

         
            VStack{
                

                
                ZStack{
                

                
                    Circle()
                .foregroundColor(Color.purple.opacity(0.5))
                .frame( width: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                      
                    NavigationLink(
                        destination: LoginPinView()                     ){
                        
                    
               Circle()
                .foregroundColor(.purple)
                .frame( width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                    
                    VStack{
                    Image(
                    systemName: "key")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(270.0))
                     
                    Text("Login")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
         
                    }
                    
                    Image(systemName: "faceid")
                        .resizable()
                        .foregroundColor(.white)
                        .offset(y: 130)
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            authentication()
                        }
                    
                    Text("Face ID")
                        .offset(y: 165)
                    
                    logoView()
                    

              
                }

         
           
            }
            .background(backgrundColor())
            .ignoresSafeArea()
      


        }
        

        
    
     
            
    }
    
    
    func authentication(){
        let context = LAContext()
            var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let resaon =  "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: resaon){
                success, authenticationError in
                DispatchQueue.main.async {
                    if success{
                        self.isUnlocked = true
                        print("authen...")
                        if isUnlocked{
                            AppView()

                        }
                    }else{
                        
                    }
                }
            }
        }else{
            
        }
        
    
    }
}

struct LoginView_Previews: PreviewProvider {

    
    static var previews: some View {
        LoginView()
    }
}


struct loginFormView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View{
        
        VStack{
        TextField("Username", text: $username)
            .padding(.all)
            
        TextField("Password", text: $password)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    
        } .background(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .padding()
        .shadow(radius: 30 )
        
        Button("Login", action: {
            
        })
        .frame(width: 296.0)
        .background(Color.purple)
        .foregroundColor(Color.white)
        .cornerRadius(20)
             .overlay(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.purple, lineWidth: 5)
             )
        .shadow(radius: 30 )
    }
}

struct logoView: View {
    var body: some View{
        VStack{
         
            HStack{
            Image(systemName: "lock")
                .resizable()
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
            
            Text("Pass Menager")
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 30))

            }
            .offset(y: 50)

                
            
            
            Spacer()

        }
    }
}



