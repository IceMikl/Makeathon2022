//
//  PhotoPickerView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: HomeViewModel
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .current
        
        let viewController = PHPickerViewController(configuration: configuration)
        viewController.delegate = context.coordinator
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> PhotoPickerView.Coordinator {
        Coordinator(self)
    }
}

extension PhotoPickerView {
    class Coordinator: PHPickerViewControllerDelegate {
        var parentView: PhotoPickerView
        
        init(_ parentView: PhotoPickerView) {
            self.parentView = parentView
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                getPhoto(from: result.itemProvider)
            }
            parentView.viewModel.dismissPhotoPicker()
        }
        
        
        
        private func getPhoto(from itemProvider: NSItemProvider) {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
         
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parentView.viewModel.capturedImage = image
                            self.parentView.viewModel.checkImage()
                        }
                    }
                }
            }
        }
    }
}
