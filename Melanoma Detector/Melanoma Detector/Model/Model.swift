//
//  Model.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import UIKit
import Alamofire
import Combine

class Model {
    var networkManager = NetworkManager()
    
    func makeTestRequest() {
        networkManager.makeGetRequest(endpoint: APIEndpoints.test.rawValue)
    }
    
    func checkImage(image: Data) -> Future<CheckImageResponse, Error> {
        networkManager.uploadImage(image: image, to: APIEndpoints.checkImageTest.rawValue, imageName: "skin.png", imageKey: "image")
    }
}
