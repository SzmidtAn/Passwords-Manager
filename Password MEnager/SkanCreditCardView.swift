//
//  SkanCreditCardView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-13.
//

import SwiftUI
import SweetCardScanner



struct SkanCreditCardView: View {
    @State var navigationStatus: NavigationStatus? = .ready
      var bankTitle: String = ""
      var cardsTyp: String = ""
    @State  var cardsNumber: String = ""
    @State    var cardsValid: String = ""
    @State  var cardsOwner: String = ""
      var cardsColor: String = ""

     // MARK: - BODY

     var body: some View {

         NavigationView {

             GeometryReader { geometry in

                 ZStack {

                     NavigationLink(
                        destination: AddNewItemView(cardsNumber: self.cardsNumber, cardsValid: self.cardsValid, cardsOwner: self.cardsOwner)
                             .onDisappear {
                               
                                 self.navigationStatus = .ready
                             },
                         tag: NavigationStatus.pop,
                         selection: $navigationStatus) {
                         EmptyView()
                     }

                 
                     if navigationStatus == .ready {
                         SweetCardScanner()
                             .onError { err in
                                 print(err)
                             }
                             .onSuccess { card in
                                 self.navigationStatus = .pop
                                if card.number != nil {
                                 
                                    cardsNumber = card.number!
                                }
                                if card.name != nil {
                                 
                        cardsOwner = card.name!
                                }
                                if card.expireDate != nil {
                                 
                                    cardsValid = "\(card.month)/\(card.year)"
                                }
                             }
                     }

                     RoundedRectangle(cornerRadius: 16)
                         .stroke()
                         .foregroundColor(.white)
                         .padding(16)
                         .frame(width: geometry.size.width, height: geometry.size.width * 0.63, alignment: .center)

//                    Text(cardsNumber)
//                    Text(cardsOwner)
//                    Text(cardsValid)
                    
                 } //: ZSTACK

             } //: GEOMETRY
         } //: NAVIGATION

     }
 }

 // MARK: - NavigationStatus
 enum NavigationStatus {
     case ready, pop
 }
