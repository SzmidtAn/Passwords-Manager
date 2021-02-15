//
//  SettingsView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-15.
//

import SwiftUI

struct SettingsView: View {
    @State private var username = UserDefaults.standard.string(forKey: "usersUsername") ?? ""
    @State private var isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    @State private var isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    @State var getTamplesColor = Color.purple
    @State var showingAlertPermission = false


    
    var body: some View {
        VStack{

        HStack{
            Text("Hello \(username)")
                .foregroundColor(Color.purple)
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


                        Text("Edit name")
                        }
                    
                    HStack{
                    Image(systemName: "lock.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.orange)


                        Text("Change pin kod")
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
            .shadow(color: Color.purple.opacity(0.8), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)


            
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

        if isNotificationsOn == false{
            
        }
        
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
                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.orange)
                .onTapGesture {
                    getTamplesColor = Color.orange
                }
       
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.green)
                .onTapGesture {
                    getTamplesColor = Color.green
                }
            
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.blue)
                .onTapGesture {
                    getTamplesColor = Color.blue
                }
        
            Rectangle()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    getTamplesColor = Color.gray
                }
        
        }
    }
}
