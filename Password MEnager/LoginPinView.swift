//
//  LoginPinView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-26.
//

import SwiftUI

struct LoginPinView: View {
    var body: some View {
        NavigationView{

         
            ZStack{
                
                Color.purple
                
                logoView()
                
                VStack{
                    

                Text("Pin kod")
                    .padding()
                
                HStack{
                    Image(systemName: "circle")
                    Image(systemName: "circle")
                    Image(systemName: "circle")
                    Image(systemName: "circle")
         
                }


                    numbersView()
                        .offset(y: 200)
                        .padding(.vertical)
               
                    

                }
                
                
            }
            .background(Color.purple)
            .foregroundColor(.white)

            .ignoresSafeArea()
  
      


        }
        
                
    }
}

struct LoginPinView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPinView()
    }
}


struct numbersView: View {
    @State var number = 0
    var body: some View{

        HStack {
        
            ForEach((4...6), id: \.self) {
                Text("\($0)")
                
                
            }
   }
      
        
        HStack {
            ForEach((4...6), id: \.self) {
                Text("\($0)")
                
            }
            .font(.system(size: 40))
            .padding([.leading, .bottom, .trailing])

   }
     

        HStack {
            ForEach((7...9), id: \.self) {
                Text("\($0)")
                
            }
            .padding([.leading, .bottom, .trailing])
            .font(.system(size: 40))
   }
        

    }
}
