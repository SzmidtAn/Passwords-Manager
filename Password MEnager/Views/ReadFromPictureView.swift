//
//  ReadFromPictureView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-29.
//

import SwiftUI
import VisionKit
import Vision

struct ReadFromPictureView: View {
    
    @State var getField = "word"
    @State private var currentDrawing: Drawing = Drawing()
    @State var imageUI: UIImage? = UIImage()

    
    @Binding var username: String
    @Binding var password: String

    @State var wordsList = [String.SubSequence]()
    
    @State var listex = [String]()
    @State var intUser = 0
    @State var intPass = 0
    @State var showingAlert = false
    @State var showingPicture = false
    @State var showingListButton = false
    @State var isShowPicker: Bool = false

    
    
  
    
    var body: some View {

        VStack{
            
    
                
                
                if !showingListButton{


                    VStack {
                        Image(uiImage: imageUI!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 320)
                        Button(action: {
                            withAnimation {
                                self.isShowPicker.toggle()
                            }
                        }) {
                            Image(systemName: "photo")
                                .font(.headline)
                            Text("IMPORT").font(.headline)
                        }.foregroundColor(.black)
                        Spacer()
                    }
                    .sheet(isPresented: $isShowPicker) {
                        ImagePicker(image: self.$imageUI)
                    }
                        

                }else{
                            List{
                                Section(header: Text("Choose \(getField)" )
                                            .foregroundColor(Color.white)
                                            .bold()
                                            .shadow(radius: 30 )){                                    ForEach(listex, id: \.self){
                                            item in

                                        ListRowReadFromPicture(item: item, username: $username, password: $password, getField: $getField)
                                       
                                         
                                        
                                
                                        }
                              
                                   
                                        .onDelete(perform: { indexSet in
                                        listex.remove(atOffsets: indexSet)
                                        })
                                
                                        

                  }
                       
                            }
                            .listStyle(InsetGroupedListStyle())
                            .shadow(color: mainColor, radius: 30)
                            .padding()
                            

                }
            
            
            HStack{
                Text("Username: ")
                    .bold()
            TextField("Loading username... ", text: $username)
                Spacer()
                Button("Set username") {
                  getField = "username"

                }
            }
            .padding(.horizontal)
            
            
            HStack{
                Text("Password: ")
                    .bold()
                TextField("Loading password...", text: $password)
                Button("Set password") {
                    getField = "password"


                }
            }
            .padding(.horizontal)

            Button(action: {
                    detectText(in: imageUI!)
                    self.showingListButton.toggle()                  })
            {
                      Text("Get text ")
                     
                        .padding()
                        .background(mainColor)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(8)
                     
            }
            .shadow(color: mainColor, radius: 4 )
            
            
   
            
            
            
            Spacer()
        }
        .background(backgrundColor())
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("No text found"), message: Text("Try a different image"), dismissButton: .default(Text("Got it!")))

              }
         
    }
  

    
    
    func handleDetectionResults(results: [Any]?) {
      guard let results = results, results.count > 0 else {
          print("No text found")
        self.showingAlert.toggle()

          return
      }
        
        var list = [String]()

      for result in results {


        if let observation = result as? VNRecognizedTextObservation {
              for text in observation.topCandidates(1) {
                let getTextString = text.string
                list.append(getTextString)
                
              
                
            
               // listex = list
                
                if getTextString == "Username:" || getTextString == "Username" ||
                    getTextString == "username" || getTextString == "Email" ||
                    getTextString == "Email:" || getTextString == "Login:"{
                     intUser = results.firstIndex { i -> Bool in
                        i as! NSObject == observation
                     }!
                }
           
                if getTextString == "Password:" || getTextString == "Password" ||
                    getTextString == "password" || getTextString == "password:"{
                    intPass = results.firstIndex { i -> Bool in
                        i as! NSObject == observation
                     }!
                            }

              }
          }
      }
        listex.append(contentsOf: list)

        var res =  results[intUser + 1] as! VNRecognizedTextObservation
    
        for getText in res.topCandidates(1){
            username = getText.string
        }
        
         res =  results[intPass + 1] as! VNRecognizedTextObservation
    
        for getText in res.topCandidates(1){
            password = getText.string
        }
        
    }
    
    
    func performDetection(request: VNRecognizeTextRequest, image: CGImage) {
      let requests = [request]
      
      let handler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
      
      DispatchQueue.global(qos: .userInitiated).async {
          do {
              try handler.perform(requests)

          } catch let error {
              print("Error: \(error)")
          }
      }
    }
    
    func detectText(in image: UIImage) {
      guard let image = image.cgImage else {
        print("Invalid image")
        return
      }
      

      let request = VNRecognizeTextRequest { (request, error) in
        if let error = error {
          print("Error detecting text: \(error)")
        } else {
          self.handleDetectionResults(results: request.results)
        }
      }
      
      request.recognitionLanguages = ["en_US"]
      request.recognitionLevel = .accurate
      
      performDetection(request: request, image: image)
    }
}

struct ReadFromPictureView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder")
    }
}



struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: UIImage?

        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = uiImage
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}

