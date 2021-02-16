//
//  SettingsView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-15.
//

import SwiftUI

struct SettingsView: View {
    @State private var username = UserDefaults.standard.string(forKey: "usersUsername") ?? ""
    @State private var password = UserDefaults.standard.string(forKey: "usersPassword") ?? ""
    @State private var isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    @State private var isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    @State var getTamplesColor = mainColor
    @State var showingAlertPermission = false
    @State var showingAlertEditName = false
    @State var showingAlertEditPassword = false
    @State var getCurrentPassword = ""
    @State var newPassword = ""


    

    
    var body: some View {
        VStack{

        HStack{
            Text("Hello \(username)")
                .foregroundColor(mainColor)
            Spacer()
            }

        .padding()
        .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .font(.largeTitle)
            
            List{
                Section{
                    
                    HStack{
                    Image(systemName: "moon.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.blue)

                        Text("Dark mode")
                      //  Spacer()
                        Toggle(isOn: $isDarkModeOn) {
                            
                        }
                        }
                    

                }
                
                
                
                Section(header: Text("Profile")){
                    
                    HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.pink)


                        if showingAlertEditName{
                            HStack{
                            TextField(username, text: $username)
                                .accentColor(Color.blue)
                                .foregroundColor(Color.blue)
                                .onReceive(newPassword.publisher.collect()) {
                                       self.newPassword = String($0.prefix(15))
                                   }
                                Button("Done", action: {
                                    showingAlertEditName.toggle()
                                })
                            }
                            
                            }else{
                        Text("Edit name")
                            .onTapGesture {
                                showingAlertEditName.toggle()
                            }
                        }
                        
                        
                        }
            
                    
                    
                    
                    HStack{
                    Image(systemName: "lock.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.orange)

                        if showingAlertEditPassword{
                            VStack{
                        
                                TextField("Current pin kod", text: $getCurrentPassword)
                                    .accentColor(Color.blue)
                                    .foregroundColor(Color.blue)
                                
                                HStack{
                                    TextField("New pin kod", text: $newPassword)
                                        .onReceive(newPassword.publisher.collect()) {
                                               self.newPassword = String($0.prefix(4))
                                           }
                                        .accentColor(Color.blue)
                                    .foregroundColor(Color.blue)
                                    
                                    Button("Done", action: {
                                        if getCurrentPassword == password{
                                        showingAlertEditPassword.toggle()
                                            password = newPassword
                                            getCurrentPassword = ""
                                            newPassword = ""
                                        }else{
                                            getCurrentPassword = "Old pin kod not accepted"
                                        }
                                    })
                                    
                                }
                            }
                            }else{
                        Text("Change pin kod")
                            .onTapGesture {
                                showingAlertEditPassword.toggle()
                            }
                        }
                    }

                }
                
                
                Section(header: Text("Notifications")){
                    
                    HStack{
                    Image(systemName: "bell.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)


                        Text("Push notifications")
                            .lineLimit(1)
                    Spacer()
                        Toggle(isOn: $isNotificationsOn) {
                            
                        }
                        .onTapGesture {

                            showingAlertPermission = true
                        }
                        .frame(width: 60)
                        .alert(isPresented: $showingAlertPermission) {
                            Alert(title: Text("Permission denied"), message: Text("You must to allow to get push notifications. Go to settings"),   primaryButton: .default(Text("Cancel"), action: {
                                isNotificationsOn.toggle()
                            }),
                                  secondaryButton: .destructive(Text("Go to settings"), action: goToSettings)
                            )
                            
                        }
                        
                        
                        }
                    

                }
                
                
                Section(header: Text("Tamples")){
                    
                    HStack{
                    Image(systemName: "pencil.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(getTamplesColor)


                        Spacer()
                        TemplesColors(getTamplesColor: $getTamplesColor)
                        
                        }
                    

                }
                
                
                
                
                
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .shadow(color: mainColor.opacity(0.8), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)


            
        }
        .onAppear{
            getUsersPrefferences()
        }
        .onDisappear{
            saveSettings()
        }

        
        
        
        
    }
    
 
    
    
    func goToSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
       getUsersPrefferences()
        saveSettings()
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
        UserDefaults.standard.set(username,  forKey: "usersUsername")
        UserDefaults.standard.set(password,  forKey: "usersPassword")
        
        getCurrentPassword = ""
        newPassword = ""
        showingAlertEditName = false
        showingAlertEditPassword = false
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct TemplesColors: View {
    @Binding var getTamplesColor: Color
    
    var body: some View{
        HStack{
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.red)
                .onTapGesture {
                    getTamplesColor = Color.red
                    mainColor = Color.red

                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.orange)
                .onTapGesture {
                    getTamplesColor = Color.orange
                    mainColor = Color.orange

                }
       
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.green)
                .onTapGesture {
                    getTamplesColor = Color.green
                    mainColor = Color.green

                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.blue)
                .onTapGesture {
                    getTamplesColor = Color.blue
                    mainColor = Color.blue

                }
        
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    getTamplesColor = Color.gray
                    mainColor = Color.gray

                }
        
        }
    }
}
