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
    
    
    init() {

    }
    var body: some View {
        Text(text)
       
        
        Button("Get text") {
            detectText(in: UIImage(named: "logintext")!)

        }
    }
    
    
    func handleDetectionResults(results: [Any]?) {
      guard let results = results, results.count > 0 else {
          print("No text found")
          return
      }

      for result in results {
        
        if let observation = result as? VNRecognizedTextObservation {
              for text in observation.topCandidates(1) {
                self.text = self.text + "\n" + text.string
                  print(text.string)
                  print(text.confidence)
                  print(observation.boundingBox)
                  print("\n")
              }
          }
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
        print("sss")
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
