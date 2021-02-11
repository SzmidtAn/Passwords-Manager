//
//  CardItemView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-02-11.
//

import SwiftUI

struct CardItemView: View {
    @State var getCardSida = 1

    var body: some View {
        
        switch getCardsSida {
        case 1:
            CardFrontView()
                

        case 2:
            CardBackView()

        default:
            CardFrontView()

        }
    
    }
}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView()
    }
}

struct CardFrontView: View {
    @State var bankTitle = 1
    @State var cardsTyp = 1
    @State var cardsNumber = 1
    @State var cardsValid = 1
    @State var cardsOwner = 1

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
                
                Spacer()
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
            .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.6), .red]), startPoint: .top, endPoint: .leading))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: Color.red.opacity(0.9) , radius: 20    , x: 10, y: 10)

            
     
        }
    }
}

struct CardBackView: View {
    var body: some View{
        ZStack{

      
        
            VStack{
            
                HStack{
            Text("Nordea")
            Spacer()
                    Text("VISA")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                .padding()
                
                Spacer()
                Text("4323 4323 2235 7786")
                    .font(.title)
                
                
                HStack{
                    Text("VALID\nTHRU")
                        .font(.system(size:7))
                        

                Text("02/23")
                }
                .padding(1.0)
                
                
                
                
                HStack{
            Text("Andreas Ericsson")
                Spacer()
                }
                .padding([ .leading, .bottom])
                
                
            }
            .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.6), .red]), startPoint: .top, endPoint: .leading))
            .foregroundColor(Color.white)
            .cornerRadius(15.0)
            .shadow(color: Color.red.opacity(0.9) , radius: 20    , x: 10, y: 10)

            
     
        }
    }
}
