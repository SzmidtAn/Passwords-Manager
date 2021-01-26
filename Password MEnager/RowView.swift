//
//  RowView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-24.
//

import SwiftUI

struct RowView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RowView_Previews: PreviewProvider {
    
    static let modelData = SavedItems()

    static var previews: some View {
        ContentView()
            .environmentObject(modelData)

    }
}

struct MailListRowView: View{
    @EnvironmentObject var savedItemsList: SavedItems
    @State   var img = "mail"
    @State   var starImage = "star"

    var item: Mails

    func doFavourite() {
        let index = savedItemsList.MailsList.firstIndex { i -> Bool in
            i.id == self.item.id
        }

        if index != nil {


            if            savedItemsList.MailsList[index!].isFovourite{
            starImage = "star.fill"
        }else{
            starImage = "star"
        }
        }
    }
    func getImage() {
        let liveAlbums = item.title

        switch liveAlbums {
      
        case "Gmail":
            img = "gmail"
        case "Hotmail":
            img = "outlook"
        default:
            img = "mail"
        }
        
    }

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(mail: item, ifCategory: false)){
            
            
        
        HStack{
         
            Image(img)
                .resizable()
                .frame(width: 20.0, height: 20.0)

        
        Text(item.title)
            
            Spacer()
            
            
          Image(systemName: starImage)
            .foregroundColor(.yellow)
                .onTapGesture {
                    
                    let index = savedItemsList.MailsList.firstIndex { i -> Bool in
                        i.id == self.item.id
                    }
                 
                    if starImage == "star"{

                        savedItemsList.MailsList[index!].isFovourite = true
                        starImage = "star.fill"
                    }else {
                        starImage = "star"
                        savedItemsList.MailsList[index!].isFovourite = false
                    }
              
                    
                }

        }
      
        
        }
   
        .onAppear(){

       getImage()
            doFavourite()
  
        }
        
    }
    
    
    
}




struct PasswordListRowView: View{
    @EnvironmentObject var savedItemsList: SavedItems
    @State   var starImage = "star"
    @State   var img = "key"

    
    var item: Password
  
    
    func doFavourite() {
        let index = savedItemsList.PasswordsList.firstIndex { i -> Bool in
                   i.id == self.item.id
               }
             if index != nil {
            if            savedItemsList.PasswordsList[index!].isFovourite{
                   starImage = "star.fill"
               }else{
                   starImage = "star"
               }
               }
    }
    
    func getImage() {
        let liveAlbums = item.title

        switch liveAlbums {
        case "Facebook":

            img = "facebook"
            
        case "Twitter":
            img = "twitter"

        case "Instagram":
            img = "instagram"
            
        case "Snapchat":
            img = "snapchat"
            
        case "LinkedIn":
            img = "linkedin"
            
        case "GitHub":
            img = "github"
            
        case "Ebay":
            img = "ebay"

        case "YouTube":
            img = "youtube"
            
            
        default:
            img = "key"
        }
        
       
        
    }
    

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(password: item)){
            HStack{
         
                Image(img)
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
                
                  
                    
       
        Text(item.title)
            
            Spacer()
            
            
          Image(systemName: starImage)
            .foregroundColor(.yellow)
                .onTapGesture {
                    
                    let index = savedItemsList.PasswordsList.firstIndex { i -> Bool in
                        i.id == self.item.id
                    }
                 
                    if starImage == "star"{

                        savedItemsList.PasswordsList[index!].isFovourite = true
                        starImage = "star.fill"
                    }else {
                     starImage = "star"
                        savedItemsList.PasswordsList[index!].isFovourite = false
                    }
              
                    
                }
        }

      
        }


        
        .onAppear(){
 
            getImage()
            doFavourite()
        }
        
    }
    
    
    
}


