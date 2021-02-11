//
//  Item.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import Foundation


struct Password: Identifiable {
    var id = UUID()
    
    var title: String
    var password: String
    var url: String = ""
    var username: String = ""

    var isFovourite = false
    
}


struct Mails: Identifiable {
    var id = UUID()
    var title: String
    var adress: String
    var password: String
    var isFovourite = false
    
}


struct Notes: Identifiable {
    var id = UUID()
    var title: String
    var note: String
    var isFovourite = false
    
}

struct CreditCard: Identifiable {
    var id = UUID()
    
  var bankTitle :String
    var cardsTyp:String
  var cardsNumber :String
    var cardsValid :String
    var cardsOwner:String
    var cardsColor: String
    
}



import CoreData

@objc(PasswordCor)
final class PasswordMO: NSManagedObject {
    @NSManaged var uuid: UUID?
    @NSManaged var title: String
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var url: String

    @NSManaged var isFavourite: Bool
}


extension PasswordMO {
    func convertToTodo() -> Password {
        Password(id: uuid ?? UUID() ,title: title, password: password  )
    }
}

@objc(MailCor)
final class MailMO: NSManagedObject {
    @NSManaged var uuid: UUID?
    @NSManaged var title: String
    @NSManaged var password: String
    @NSManaged var adress: String
    

    @NSManaged var isFavourite: Bool
}


extension MailMO {
    func convertToTodo() -> Mails {
        Mails(id: uuid ?? UUID() ,title: title, adress: adress, password: password  )
    }
}


@objc(NoteCor)
final class NoteMO: NSManagedObject {
    @NSManaged var uuid: UUID?
    @NSManaged var title: String
    @NSManaged var note: String
    
    @NSManaged var isFavourite: Bool
}


extension NoteMO {
    func convertToTodo() -> Notes
{
        Notes(id: uuid ?? UUID() ,title: title, note: note  )
        
    }
}


@objc(CardCor)
final class CreditCardMO: NSManagedObject {
    @NSManaged var uuid: UUID?

    
    @NSManaged  var bankTitle :String
    @NSManaged   var cardsTyp:String
    @NSManaged  var cardsNumber :String
    @NSManaged    var cardsValid :String
    @NSManaged    var cardsOwner:String
    @NSManaged   var cardsColor: String
      
}


extension CreditCardMO {
    func convertToTodo() -> CreditCard
{
CreditCard(id: uuid ?? UUID(), bankTitle: bankTitle, cardsTyp: cardsTyp, cardsNumber: cardsNumber, cardsValid: cardsValid, cardsOwner: cardsOwner, cardsColor: cardsColor)
    }
}
