//
//  MailDetailView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-24.
//

import SwiftUI

struct MailDetailView: View {
    var item : Mails
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MailDetailView(item: Mails(title: "edw", adress: "fwef", password: "fwef"))
    }
}
