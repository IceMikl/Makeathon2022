//
//  CameraView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import Foundation
import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: HomeViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> CameraView.Coordinator {
        Coordinator(self)
    }
}

extension CameraView {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parentView: CameraView
        
        init(_ parentView: CameraView) {
            self.parentView = parentView
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parentView.viewModel.dismissCamera()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parentView.viewModel.capturedImage = image
                parentView.viewModel.checkImage()
                parentView.viewModel.dismissCamera()
            }
        }
    }
}
