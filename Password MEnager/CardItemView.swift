//
//  CardItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-11.
//

import SwiftUI

struct CardItemView: View {
    @State var getCardSida = 1
    @State var currentCreditCard = 0
    @State var getCreditCard = CreditCardCore()
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
     var creditsCardsList: FetchedResults<CreditCardCore>

    var body: some View {
        
        VStack{
            
            ZStack{
                ForEach(0..<creditsCardsList.count){card in
                    if card != currentCreditCard && card > 2 {
                    CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[card], currentCreditCard: $currentCreditCard)
                        .offset(x: CGFloat(-10 * card), y: CGFloat(40 * card))
                    }
                }
            }
            .offset(x: 10)

          Spacer()

        switch getCardSida {
        case 1:
          CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[self.currentCreditCard], currentCreditCard: $currentCreditCard)

        case 2:
            CardBackView(cardSida: $getCardSida, getCreditCard: creditsCardsList[currentCreditCard], currentCreditCard: $currentCreditCard)

        case 3:
            CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[self.currentCreditCard], currentCreditCard: $currentCreditCard)

        default:
            CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[1], currentCreditCard: $currentCreditCard)

        }
            Spacer()
        
        }
        .background(Color("backgrund"))

    }
    
}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView()
    }
}

struct CardFrontView: View {
    @Binding var cardSida: Int
   @State var cardsColor: Color = Color.red
    var getCreditCard: CreditCardCore
    @Binding var currentCreditCard: Int
    @State private var hasOffset = false
    @State private var zIndex:CGFloat = 1.0
    @State private var degrees = 0.0

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
     var creditsCardsList: FetchedResults<CreditCardCore>
    
    var body: some View{
        ZStack{
            VStack{
                        HStack{
                    Text(getCreditCard.bankTitle!)
            Spacer()
                    Text(getCreditCard.cardsTyp!)
                        .font(.title)
                        .fontWeight(.heavy)
                }
                .padding()
                HStack{
                Image("chip")
                    .resizable()
                    .frame(width: 60, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               Spacer()
                }
                .padding(.leading)
                
                Text(getCreditCard.cardsNumber!)
                    .font(.title)
                HStack{
                    Text("VALID\nTHRU")
                        .font(.system(size:7))
                    Text(getCreditCard.cardsValid!)
                }
                .padding(1.0)
                HStack{
                    Text(getCreditCard.cardsOwner!)
                Spacer()
                }
                .padding([ .leading, .bottom])
            }
            .frame(width: 350, height: 220, alignment: .center)
            .background(cardsBackgrundColor(getCardsColor: cardsColor))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: cardsColor.opacity(0.8) , radius: 10   , x: 10, y: 10)
            .offset(y: hasOffset ? 300 : 0)
            .zIndex(Double(hasOffset ? 30 : 0 + currentCreditCard))
            .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 1, z: 1))
                       .onTapGesture {
                        currentCreditCard =    creditsCardsList.firstIndex(where: { i in i.id == getCreditCard.id })!
                        if cardSida == 1{
                        cardSida = 3
                        }else{
                            cardSida = 1
                        }
                            }
            .gesture(
                    DragGesture(minimumDistance: 20)
                                   .onEnded { _ in
                                    self.cardSida = 2
                                   }
                           )
            .padding(.bottom)
            .onAppear{
               changeCard()
            }
        }
    }
    
    func changeCard()  {
        switch getCreditCard.cardsColor {
        case "red":
            self.cardsColor = Color.red
        case "blue":
            self.cardsColor = Color.blue
        case "orange":
            self.cardsColor = Color.orange
        case "green":
            self.cardsColor = Color.green
        case "gray":
            self.cardsColor = Color.gray

        default:
            self.cardsColor = Color.red
        }
    }
}

struct CardBackView: View {

    @Binding var cardSida: Int
   @State var cardsColor: Color = Color.red
    var getCreditCard: CreditCardCore
    @Binding var currentCreditCard: Int
    

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
     var creditsCardsList: FetchedResults<CreditCardCore>

    
    var body: some View{
        ZStack{

            VStack{
                Rectangle()
                    .frame( height: 60)
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding(.top)

                HStack{
                Rectangle()
                    .background(Color.black)
                    .frame( width: 200,  height: 45)

                    Text(getCreditCard.cvv ?? "366")
                        .padding(5.0)

                        .background(Color.white)
                        .foregroundColor(.black)
                        
                
                    Spacer()

                }
                .padding(.leading)
                Spacer()

                
            }
            .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(cardsBackgrundColor(getCardsColor: cardsColor))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: cardsColor.opacity(0.9) , radius: 20    , x: 10, y: 10)
            .onTapGesture {
                self.cardSida = 1
                changeCard()
            }
            .onAppear{
                changeCard()
            }
            .gesture(
                               DragGesture(minimumDistance: 20)
                                   .onEnded { _ in
                                    self.cardSida = 1
                                   }
                           )
        }
    }
    
    func changeCard()  {
        switch getCreditCard.cardsColor {
        case "red":
            self.cardsColor = Color.red
        case "blue":
            self.cardsColor = Color.blue
        case "yellow":
            self.cardsColor = Color.yellow
        case "green":
            self.cardsColor = Color.green
        case "gray":
            self.cardsColor = Color.gray

        default:
            self.cardsColor = Color.red

        }
    }
}


struct cardsBackgrundColor:View {
    var cardsColor: Color
    var cardsColorLight: Color

    init(getCardsColor: Color) {
    self.cardsColor =  getCardsColor
        self.cardsColorLight = getCardsColor.opacity(0.5)
    }

    var body: some View{
        LinearGradient(
            gradient: Gradient(colors: [cardsColor, cardsColor.opacity(0.3), cardsColor.opacity(0.8)]),
          startPoint: UnitPoint(x: 0.0, y: 0.0),
          endPoint: .bottomTrailing
        )
        .background(Color.white)
    }
}
