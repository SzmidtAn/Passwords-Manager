//
//  CardItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-11.
//

import SwiftUI

struct CardItemView: View {
    @State var getCardSida = 1
    var currentCreditCard = 0
    @State var getCreditCard = CreditCardCore()
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CreditCardCore.bankTitle, ascending: true)],
        animation: .default)
    private var creditsCardsList: FetchedResults<CreditCardCore>

   
    var body: some View {
        
        VStack{
        
            ZStack{
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[1])
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[1])
                .offset(x: -10, y: 40)
                CardFrontView( cardSida: $getCardSida,  getCreditCard: creditsCardsList[1])
                .offset(x: -20, y: 80)
                CardFrontView( cardSida: $getCardSida, getCreditCard: creditsCardsList[1])
                .offset(x: -30, y: 120)

            }
            .offset(x: 10)

            Spacer()
            
        switch getCardSida {
        case 1:
            CardFrontView( cardSida: $getCardSida, getCreditCard: getCreditCard)


        case 2:
            CardBackView(cardSida: $getCardSida)

        default:
            CardFrontView( cardSida: $getCardSida,  getCreditCard: getCreditCard)

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
    @State var bankTitle = "Nordea"
    @State var cardsTyp = "VISA"
    @State var cardsNumber = "4323 4323 2235 7786"
    @State var cardsValid = "02/23"
    @State var cardsOwner = "Andreas Ericsson"
    @Binding var cardSida: Int
    var cardsColor: Color = Color.red
    var getCreditCard: CreditCardCore
    //   @Binding var currentCreditCard: Int


    
    var body: some View{
        ZStack{

      
        
            VStack{
            
                HStack{
            Text(bankTitle)
            Spacer()
                    Text(cardsTyp)
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
                
                Text(cardsNumber)
                    .font(.title)
                
                
                HStack{
                    Text("VALID\nTHRU")
                        .font(.system(size:7))
                        

                Text(cardsValid)
                }
                .padding(1.0)
                
                
                
                
                HStack{
            Text(cardsOwner)
                Spacer()
                }
                .padding([ .leading, .bottom])
                
                
            }
            .frame(width: 350, height: 220, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [cardsColor.opacity(0.6), cardsColor]), startPoint: .top, endPoint: .leading))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: cardsColor.opacity(0.9) , radius: 20    , x: 10, y: 10)
            .onTapGesture {
                self.cardSida = 2
            }
            .padding(.bottom)
            

            
     
        }
        
    }
}

struct CardBackView: View {
    @Binding var cardSida: Int
    var ccv: String = "336"

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

                    Text(ccv)
                        .padding(5.0)

                        .background(Color.white)
                        .foregroundColor(.black)
                        
                
                    Spacer()

                }
                .padding(.leading)
                Spacer()

                
            }
            .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.6), .red]), startPoint: .top, endPoint: .leading))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: Color.red.opacity(0.9) , radius: 20    , x: 10, y: 10)
            .onTapGesture {
                self.cardSida = 1
            }

            
     
        }
    }
}
