//
//  AppView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI
 var getView = true
 var getViewList = true

struct AppView: View {
    let name: String
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
     var creditsCardsList: FetchedResults<CreditCardCore>

    @State private var isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    @State private var isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PasswordCore.title, ascending: true)],
        animation: .default)
    private var passwordsList: FetchedResults<PasswordCore>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MailCore.title, ascending: true)],
        animation: .default)
    private var MailsList: FetchedResults<MailCore>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteCore.title, ascending: true)],
        animation: .default)
    private var NotesList: FetchedResults<NoteCore>

    

        
    
    
    
    var body: some View {


 

        
        
        TabView {
            
             
            if passwordsList.count > 0 || NotesList.count > 0 ||  MailsList.count > 0 {
            ContentView(getName: self.name)
            
            .tabItem {
                  Image(systemName: "list.dash")
                  Text("Accounts")
            }.tag(0)
            }else{
                
                EmptyListView()
                .tabItem {
                      Image(systemName: "list.dash")
                      Text("Accounts")
                }.tag(0)
                
            }
            
            
            
            if creditsCardsList.count > 0 {
                CardItemView()
                .tabItem {
                          Image(systemName: "creditcard.fill")
                          Text("Wallet")
                    }.tag(1)
            }
            
            if creditsCardsList.count == 0 {
                
              GetCreditsCardsVie()
                    .tabItem {
                          Image(systemName: "creditcard.fill")
                          Text("Wallet")
                    }.tag(1)
                
                
            }
      
            
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
        .accentColor(mainColor)
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

struct GetCreditsCardsVie:View {
    var body: some View {
         NavigationView {
            VStack{
            
                Image("empty_wallet")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("No Credit Cards Yet!")
                    .fontWeight(.heavy)
                Text("Please add some credit card to your account  ")
                    .fontWeight(.light)
                    .lineLimit(2)
          
                NavigationLink(destination: AddNewItemView(selectedStrength: 3)) {
                    
                    Text("Add a credit card")
                    .padding()
                    .background(mainColor)
                    .foregroundColor(Color("backgrund"))
                    .cornerRadius(40)
                    
                              }
            }
            .offset(y:-50)
         }
     }
 }


struct EmptyListView:View {
    var body: some View {
         NavigationView {
            VStack{
            
                Image("empty_password")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("No Passwords Yet!")
                    .fontWeight(.heavy)
                Text("Please add some password to your account  ")
                    .fontWeight(.light)
                    .lineLimit(2)
          
                NavigationLink(destination: AddNewItemView()) {
                    
                    Text("Add a password")
                    .padding()
                    .background(mainColor)
                    .foregroundColor(Color("backgrund"))
                    .cornerRadius(40)
                    
                              }
            }
            .offset(y:-50)
       
         }
     }
 }


struct EmptyFavouriteListView:View {
    var body: some View {
         NavigationView {
            VStack{
            
                Image("empty_password")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("No Passwords Yet!")
                    .fontWeight(.heavy)
                Text("Please add some password to your account  ")
                    .fontWeight(.light)
                    .lineLimit(2)
          
                NavigationLink(destination: AddNewItemView()) {
                    
                    Text("Add a password")
                    .padding()
                    .background(mainColor)
                    .foregroundColor(Color("backgrund"))
                    .cornerRadius(40)
                    
                              }
            }
            .offset(y:-50)
       
         }
     }
 }

