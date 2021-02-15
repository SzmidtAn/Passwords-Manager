//
//  AppView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct AppView: View {
    let name: String
    @State private var isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    @State private var isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    
    var body: some View {


 

        
        
        TabView {
            
            ContentView(getName: self.name)
            
            .tabItem {
                  Image(systemName: "list.dash")
                  Text("Accounts")
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
            SettingsView()
                 .tabItem {
                    Image(systemName: "gearshape.2.fill")
                    Text("Settings")
                 
          
                
            }.tag(3)
        

        
        
        
    }
        .accentColor(.purple)
        .onAppear{
            getUsersPrefferences()
            saveSettings()
        }
      
  
        
}
    
    func getUsersPrefferences() {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                isNotificationsOn = false
            } else if settings.authorizationStatus == .denied {
                isNotificationsOn = false
            } else if settings.authorizationStatus == .authorized {
                isNotificationsOn = true

                
            }
        })
    }
    
    func saveSettings() {
        UserDefaults.standard.set(isDarkModeOn,  forKey: "isDarkModeOn")
        UserDefaults.standard.set(isNotificationsOn,  forKey: "isNotificationsOn")

        if isNotificationsOn == false{
            
        }
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(name: "NAME")
    }
}

