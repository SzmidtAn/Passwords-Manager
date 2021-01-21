//
//  AppView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct AppView: View {
    var body: some View {


 

            
        
        TabView {
            
         ContentView()
            .tabItem {
                  Image(systemName: "list.dash")
                  Text("List")
            }.tag(0)
            
   
            
            
            Text("Favourits").tabItem {
                Image(systemName: "star.fill")
                Text("Favourits")
                
                
            }.tag(1)
        
            Text("Settings").tabItem {
                Image(systemName: "gearshape.2.fill")
                Text("Settings")
                
                
            }.tag(2)
        

        
        
        
    }
        .accentColor(.purple)
         
  
        
}
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

