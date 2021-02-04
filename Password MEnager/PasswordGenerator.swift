//
//  PasswordGenerator.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-23.
//

import SwiftUI

struct PasswordGenerator: View {
    
    @State private var length = 9
    @Binding  var pass: String

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        

        VStack{
        
            
            TextField("Password", text: $pass)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

            Stepper("Characters: \(length)", value: $length, in: 6...25)
            Button("Generate password", action: autoPasswordGenerator)
                .padding()
                .border(Color.purple)
         
        }
        .padding()
        .cornerRadius(30)
        
        
    }
    
    func autoPasswordGenerator(){
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         pass =   String((0..<length).map{ _ in letters.randomElement()! })
        
        
            
        
    }
}

struct PasswordGenerator_Previews: PreviewProvider {
    static var previews: some View {
        Text("efd")
    }
}
