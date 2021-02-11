//
//  AppView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct AppView: View {
    let name: String
    var body: some View {


 

        
        
        TabView {
            
            ContentView(getName: self.name)
            
            .tabItem {
                  Image(systemName: "list.dash")
                  Text("List")
            }.tag(0)
            
        CardItemView()
            .tabItem {
                  Image(systemName: "creditcard.fill")
                  Text("Wallet")
            }.tag(1)
            
           FavouriteView()
                .tabItem {
                Image(systemName: "star.fill")
                Text("Favorite")
                
                
            }.tag(2)
        
            Text("Settings").tabItem {
                Image(systemName: "gearshape.2.fill")
                Text("Settings")
                
                
            }.tag(3)
        

        
        
        
    }
        .accentColor(.purple)
         
  
        
}
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(name: "NAME")
    }
}

