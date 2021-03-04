//
//  SkanCreditCardView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-13.
//

import SwiftUI
import Foundation
import SweetCardScanner
import AVKit


struct SkanCreditCardView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var navigationStatus: NavigationStatus? = .ready
      var bankTitle: String = ""
      var cardsTyp: String = ""
    @State  var cardsNumber: String = ""
    @State    var cardsValid: String = ""
    @State  var cardsOwner: String = ""
      var cardsColor: String = ""
  //  private let player = AVPlayer(url: URL(string: "https://vimeo.com/519600221")!)

     // MARK: - BODY

     var body: some View {

         NavigationView {

             GeometryReader { geometry in

                 ZStack {

                     NavigationLink(
                        destination: AddNewItemView(cardsNumber: self.cardsNumber, cardsValid: self.cardsValid, cardsOwner: self.cardsOwner, selectedStrength: 3)
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
                             //   player.play()

                       

                                cardsNumber = "4366 7757 4493 3558"
                                cardsValid = "04/23"
                                cardsOwner = "Aneta Szmidt"

                             }
                             .onSuccess { card in
                           
                                if card.number != nil {
                                 
                                    cardsNumber = card.number!
                                }
                                if card.name != nil {
                                 
                        cardsOwner = card.name!
                                }
                                if card.expireDate != nil {
                                 
                                    cardsValid = "\(card.month)/\(card.year)"
                                }
                                
                                self.navigationStatus = .pop

                             }
               

                     }

                     RoundedRectangle(cornerRadius: 16)
                         .stroke()
                         .foregroundColor(.white)
                         .padding(16)
                         .frame(width: geometry.size.width, height: geometry.size.width * 0.63, alignment: .center)
                    
               //     VideoPlayer(player: player)
                    
                    Image("skana_card")
                        .resizable()
                       //   .frame(width: 400.0, height: 700.0)
                               

//                    Text(cardsNumber)
//                    Text(cardsOwner)
//                    Text(cardsValid)
                    
                 } //: ZSTACK
                 .background(Color.black)
            
             } //: GEOMETRY
         } //: NAVIGATION
       

     }
 }

 // MARK: - NavigationStatus
 enum NavigationStatus {
     case ready, pop
 }
