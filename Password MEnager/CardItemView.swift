//
//  CardItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-11.
//

import SwiftUI

struct CardItemView: View {
    @State var getCardSida = 1
    @State var currentCreditCard = 1
    @State var getCreditCard = CreditCardCore()
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
     var creditsCardsList: FetchedResults<CreditCardCore>

  
    
    
   
    var body: some View {
        
        VStack{
        
            ZStack{
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[5], currentCreditCard: $currentCreditCard)
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[6], currentCreditCard: $currentCreditCard)
                .offset(x: -10, y: 40)
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[3], currentCreditCard: $currentCreditCard)
                .offset(x: -20, y: 80)
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[4], currentCreditCard: $currentCreditCard)
                .offset(x: -30, y: 120)

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
        
        .background( Color.white.opacity(0))
    
        
    
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
            .background(LinearGradient(gradient: Gradient(colors: [cardsColor, cardsColor]), startPoint: .top, endPoint: .leading))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: cardsColor.opacity(0.9) , radius: 20    , x: 10, y: 10)
            .onTapGesture {

             currentCreditCard =    creditsCardsList.firstIndex(where: { i in i.id == getCreditCard.id })!
                changeCard()
                
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

                    Text("336")
                        .padding(5.0)

                        .background(Color.white)
                        .foregroundColor(.black)
                        
                
                    Spacer()

                }
                .padding(.leading)
                Spacer()

                
            }
            .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: Gradient(colors: [cardsColor, cardsColor]), startPoint: .top, endPoint: .leading))
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
