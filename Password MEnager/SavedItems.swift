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
        PasswordsList.append(Password(title: "Facebook", password: "dfewfd43"))
        PasswordsList.append(Password(title: "Twitter", password: "dfewfd43"))
        PasswordsList.append(Password(title: "Gmail", password: "dfewfd43", isFovourite: true))
        PasswordsList.append(Password( title: "dew", password: "ded", isFovourite: true))
        PasswordsList.append(Password(title: "Instagram", password: "dfewfd43"))
        PasswordsList.append(Password(title: "Facebook", password: "dfewfd43"))
        PasswordsList.append(Password(title: "Hotmail", password: "dfewfd43", isFovourite: true))
        PasswordsList.append(Password(title: "Facebook", password: "dfewfd43"))
        
        MailsList.append(Mails(title: "Gmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "School", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "Hotmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "Work", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "Hotmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))
        MailsList.append(Mails(title: "Gmail", adress: "a.szmidt95@gmail.com", password: "dfewfd43"))



    }
    
    func add (item: Password){
        PasswordsList.append(item)
    }
    

    
}


