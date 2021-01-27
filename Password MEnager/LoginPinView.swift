//
//  LoginPinView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-26.
//

import SwiftUI

struct LoginPinView: View {
    var chunkedArray = [1, 2, 3, 4]
    @State var num = ""
    @State var circle1 = "circle"
    @State var circle2 = "circle"
    @State var circle3 = "circle"
    @State var circle4 = "circle"
    let pinKod = "1212"

    private var mixedLayout = [GridItem(.adaptive(minimum: 100))]

    
    var body: some View {
        NavigationView{

         
            ZStack{
                
                Color.purple
                
                logoView()
                
                VStack{
                    

                Text("Pin kod")
                    .padding()
                
                HStack{
                    Image(systemName: circle1)
                    Image(systemName: circle2)
                    Image(systemName: circle3)
                    Image(systemName: circle4)

         
                }

                    
                    LazyVGrid(columns: mixedLayout, spacing: 20) {
                              
                                  ForEach((1...9), id: \.self) { i in
                                    Text("\(i)")
                                        .padding()
                                          .font(.title)
                                        .onTapGesture {

                                            num = num + String(i)
                                            
                                            switch num.count{
                                            case 1:
                                                circle1 = "circle.fill"
                                            case 2:
                                                circle2 = "circle.fill"
                                            case 3:
                                                circle3 = "circle.fill"
                                            case 4:
                                                circle4 = "circle.fill"
                                                checkPin()
                                            default:
                                             break
                   
                                            }
                                            
                                            
                                            print(num)
                                            
                                        }
                                  }
                              }
                                        .offset(y: 150)
                    .padding()

                    

                }

                
                
            }
            .background(Color.purple)
            .foregroundColor(.white)

            .ignoresSafeArea()
  
      


        }
        
                
    }
    
    func checkPin(){
        if num == pinKod{
            print("PIN OK")
            circle4 = "circle.fill"

            AppView()

        }else{
            print("PIN FEL")
            circle1 = "circle"
            circle2 = "circle"
            circle3 = "circle"
            circle4 = "circle"
            num = ""
            
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
