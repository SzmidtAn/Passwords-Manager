//
//  SavedItems.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI


class SavedItems : ObservableObject{
    
    @Published var PasswordsList = [Password]()
    @Published var MailsList = [Mails]()
    
    init() {
        PasswordsList.append(Password(title: "Facebook", password: "dfewfd43", url: "www.sidaweb.com"))
        PasswordsList.append(Password(title: "Twitter", password: "dfewfd43", url: "www.sidaweb.com"))
        PasswordsList.append(Password(title: "GitHub", password: "dfewfd43", url: "www.sidaweb.com", isFovourite: true))
        PasswordsList.append(Password( title: "YouTube", password: "ded", url: "www.sidaweb.com", isFovourite: true))
        PasswordsList.append(Password(title: "Instagram", password: "dfewfd43", url: "www.sidaweb.com"))
        PasswordsList.append(Password(title: "LinkedIn", password: "dfewfd43", url: "www.sidaweb.com"))
        PasswordsList.append(Password(title: "Snapchat", password: "dfewfd43", url: "www.sidaweb.com", isFovourite: true))
        PasswordsList.append(Password(title: "Ebay", password: "dfewfd43", url: "www.sidaweb.com"))
        
        MailsList.append(Mails(title: "Gmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "School", adress: "a.szmidt95@gmail.com", password: "dfewfd43", isFovourite: true))
        MailsList.append(Mails(title: "Onet", adress: "a.szmidt95@gmail.com", password: "dfewfd43", isFovourite: true))
        MailsList.append(Mails(title: "Work", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "Hotmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43", isFovourite: true))
        MailsList.append(Mails(title: "Home mail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))



    }
    
    func add (item: Password){
        PasswordsList.append(item)
    }
    

    
}


