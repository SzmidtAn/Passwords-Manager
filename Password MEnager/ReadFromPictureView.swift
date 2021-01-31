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
    
    @State var text = "text"
    var image = UIImage(named: "logintext")
    
    @State var usernamn = ""
    @State var password = ""

    @State var wordsList = [String.SubSequence]()
    
   @State var listex = ["first"]
    @State var intUser = 0
    @State var intPass = 0

    
    
  
    
    var body: some View {

        VStack{
       Image("logintext")
        .resizable()
        .frame(width: 200, height: 400, alignment: .top)

            Text("Username: " + usernamn)
            Text("Password: " + password)

        Button("Get text") {
            detectText(in: image!)
        }
            
        }
         
    }
  
    func getLoginInfo(){
        intUser = listex.firstIndex(of: "Username:")!
        intPass = listex.firstIndex(of: "Password:")!

        usernamn = listex[intUser + 1]
        password = listex[intPass + 1]
        
    }
    
    
    
    func handleDetectionResults(results: [Any]?) {
      guard let results = results, results.count > 0 else {
          print("No text found")
          return
      }

      for result in results {
        
        if let observation = result as? VNRecognizedTextObservation {
              for text in observation.topCandidates(1) {
                
                    listex.append(text.string)
                    
                print(listex.count)

              }
          }
      }
     getLoginInfo()
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
        ReadFromPictureView()
    }
}


