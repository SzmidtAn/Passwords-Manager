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

    @EnvironmentObject var savedItemsList: SavedItems
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        

        VStack{
        

            TextField("Password", text: $pass)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

            Stepper("How many characters: \(length)", value: $length, in: 3...20)
                .padding()
            Button("Generate password", action: autoPasswordGenerator)
                .padding()
        }
        .onDisappear()
        
        
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
