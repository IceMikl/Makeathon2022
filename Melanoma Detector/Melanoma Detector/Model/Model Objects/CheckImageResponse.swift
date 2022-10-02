//
//  CheckImageResponse.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 02.10.22.
//

import Foundation

struct CheckImageResponse: Codable {
    var result: Double
    var image: String
}
