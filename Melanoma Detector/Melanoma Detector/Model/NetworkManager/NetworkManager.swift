//
//  NetworkManager.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI
import Alamofire
import Combine

class NetworkManager {
    enum HTTPMethod: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
    }
    
    var baseUrl: String {
        return Bundle.main.infoDictionary!["ServerURL"] as! String
    }
    
    var session: URLSession {
        URLSession.shared
    }
    
    private func getUrl(endpoint: String?) -> String {
        if let endpoint = endpoint {
            return "\(baseUrl)/\(endpoint)"
        } else {
            return baseUrl
        }
    }
    
    func makeGetRequest(endpoint: String?) {
        let url = getUrl(endpoint: endpoint)
        let request = AF.request(url)
        request.responseString { (data) in
            if let response = data.value {
                print(response)
            }
        }
    }
    
    func uploadImage(image: Data, to endpoint: String, imageName: String, imageKey: String) -> Future<CheckImageResponse, Error> {
        Future { promise in
            let url = self.getUrl(endpoint: endpoint)
            
            AF.upload(multipartFormData: { multiPart in
                multiPart.append(image, withName: imageKey, fileName: imageName, mimeType: "image/png")
            }, to: url)
                .uploadProgress(queue: .main, closure: { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseDecodable(of: CheckImageResponse.self, completionHandler: { response in
                    guard let response = response.value else { return }
                    promise(.success(response))
                })
        }
        
    }
}
