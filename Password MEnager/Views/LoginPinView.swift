//
//  LoginPinView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-26.
//

import SwiftUI

struct LoginPinView: View {
    @State var num = ""
    @State var circle1 = "circle"
    @State var circle2 = "circle"
    @State var circle3 = "circle"
    @State var circle4 = "circle"
    @Binding var pincode: String
    @Binding var username: String

    @State private var showingAlert = false
    @Binding var isUser: Bool
    
    @State var pincodeText: String = ""
    
        


    
    @Binding var isUnlocked: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Environment(\.managedObjectContext) private var viewContext


   
     var mixedLayout = [GridItem(.adaptive(minimum: 100))]

    
    
    
    var body: some View {


        if isUnlocked {
        }else{
        
        NavigationView{

         
            ZStack{
                
                mainColor
                
                logoView()
                
                VStack{
                    
                    if !isUser{
                    HStack{
                    Label("What's your name?", image: "person")
                        
                        TextField("Username", text: $username)
                        
                        Spacer()
                    }
                    }else{
                        Text("Hello \(username)")
                        
                    }
                   
                    
                    
                Text(pincodeText)
                    .padding()
                
                HStack{
                    Image(systemName: circle1)
                    Image(systemName: circle2)
                    Image(systemName: circle3)
                    Image(systemName: circle4)

         
                }

                    
                    LazyVGrid(columns: mixedLayout, spacing: 20) {
                              
                                  ForEach((1...9), id: \.self) { i in
                                    Text("\(i)")
                                        .padding()
                                          .font(.title)
                                        .onTapGesture {

                                            num = num + String(i)
                                            
                                            switch num.count{
                                            case 1:
                                                circle1 = "circle.fill"
                                            case 2:
                                                circle2 = "circle.fill"
                                            case 3:
                                                circle3 = "circle.fill"
                                            case 4:
                                                circle4 = "circle.fill"
                                              
                                                if isUser{
                                                    checkPin()

                                                }else{
                                                    saveNewPin()
                                                }
                                                
                                                
                                                
                                            default:
                                                isUnlocked = false
                                             break
                   
                                            }
                                            
                                            
                                            
                                        }
                                  }
                              }
                                        .offset(y: 150)
                    .padding()

                    

                }

                
                
            }
            .onAppear{
                checkIfUser()
            }
            
            .background(mainColor)
            .foregroundColor(.white)

            .ignoresSafeArea()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello \(username)"), message: Text("Your PIN is: \(pincode)"), dismissButton: .default(Text("Got it!")){
                    self.isUnlocked = true
                    self.presentationMode.wrappedValue.dismiss()

                })
                  }
  
      


        }
        
        }
                
    }
    
    func checkIfUser(){
        
        if isUser{
            pincodeText = "Enter your PIN"
        }else{
            pincodeText = "You can choose your PIN"
        }
    }
    
    func checkPin(){
        print(pincode)
        if num == pincode{
            circle4 = "circle.fill"

            isUnlocked = true
            

           self.presentationMode.wrappedValue.dismiss()


        }else{
            circle1 = "circle"
            circle2 = "circle"
            circle3 = "circle"
            circle4 = "circle"
            num = ""
            
        }
    }
    
    func saveNewPin() {
        pincode = num
        UserDefaults.standard.set(pincode,  forKey: "usersPassword")
        UserDefaults.standard.set(username,  forKey: "usersUsername")


        isUser = true
        UserDefaults.standard.set(isUser,  forKey: "ifUser")
        showingAlert = true
      

    }
    
}

struct LoginPinView_Previews: PreviewProvider {
    static var previews: some View {

        Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
    }
}


struct numbersView: View {
    @State var number = 0
    var body: some View{

        HStack {
        
            ForEach((4...6), id: \.self) {
                Text("\($0)")
                
                
            }
   }
      
        
        HStack {
            ForEach((4...6), id: \.self) {
                Text("\($0)")
                
            }
            .font(.system(size: 40))
            .padding([.leading, .bottom, .trailing])

   }
     

        HStack {
            ForEach((7...9), id: \.self) {
                Text("\($0)")
                
            }
            .padding([.leading, .bottom, .trailing])
            .font(.system(size: 40))
   }
        

    }
}
