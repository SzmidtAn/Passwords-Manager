//
//  ContentView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct ContentView: View {
    var navBackgroundImage = UIImage(systemName: "tramsparent")
    @Environment(\.colorScheme) var colorScheme


    
    
    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [  .foregroundColor: UIColor.white]
        
        UITableView.appearance().backgroundColor = UIColor(Color.white.opacity(0))
    }
    
    
    var body: some View {
     
        NavigationView{

       
            
            ZStack{

                
                ListsView()
                
                
                HStack{
                    addNewButton()
         }.zIndex(3.0)
                .offset(y: -100)
                
                Spacer()
        
            }
            
.navigationBarTitle("Accounts")
       
            .navigationBarItems(trailing: EditButton())
            .background(backgrundColor())
            .ignoresSafeArea()


        }
        
    
    }

    
}


struct ContentView_Previews: PreviewProvider {

    
    static let modelData = SavedItems()

    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
         //   .environment(\.colorScheme, .dark)


    }
}

struct addNewButton: View {
    var body: some View{
        Spacer(    )
         VStack{
    Spacer(     )

     NavigationLink(
         destination: AddNewItemView()    ){
         
     Image(systemName: "plus.circle")
     .resizable()
         .frame(width: 50, height: 50)
     .clipShape(Circle())
         .foregroundColor(.white)
         .background(Color.purple)
         .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
     .overlay(Circle().stroke(Color.white, lineWidth: 3))
     .shadow(radius: 20)
        .animation(.easeIn)

     }
}
     .padding()
    }
}

struct ListsView: View {
    
    @EnvironmentObject var savedItemsList: SavedItems

    @State private var paymentType = 0
    static let paymentTypes = ["Cash", "CredicCard", "iDinePoints"]

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PasswordCore.title, ascending: true)],
        animation: .default)
    private var passwordsList: FetchedResults<PasswordCore>

    
    
    
    var body: some View{
        
                List{
                    Section(header: Text("Passwords")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                                .shadow(radius: 30 )){
                            ForEach(passwordsList){
                                item in
                                PasswordListRowView(item: item)
                                    
                                    
                        
                    
                            }
                            .onDelete(perform: { indexSet in
                                withAnimation {
                                    indexSet.map { passwordsList[$0] }.forEach(viewContext.delete)

                                    do {
                                        try viewContext.save()
                                    } catch {
                                     
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                            })
                            

      }
                    


                    Section(header: Text("Mails")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                                .shadow(radius: 30 )){
                        ForEach(savedItemsList.MailsList){
                            item in
                            MailListRowView(item: item)
                        }
                        .onDelete(perform: { indexSet in
                            savedItemsList.MailsList.remove(atOffsets: indexSet)
                        })
       }
                    
                    Section(header: Text("Notes")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                                .shadow(radius: 30 )){                            ForEach(savedItemsList.NotesList){
                                item in
                                NotesListRowView(item: item)
                        
                    
                            }
                            .onDelete(perform: { indexSet in
                                savedItemsList.PasswordsList.remove(atOffsets: indexSet)
                            })
                            
                        
                        
    }
                    
                }

                
                

                .listStyle(InsetGroupedListStyle())
                .shadow(color: Color.purple, radius: 10 )

        
        
    }

}

struct backgrundColor: View {
    var body: some View{
        LinearGradient(
            gradient: Gradient(colors: [.purple, .white, .white]),
          startPoint: UnitPoint(x: 0.0, y: 0.0),
          endPoint: .bottomTrailing
        )
    }
}

