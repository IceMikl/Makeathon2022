//
//  HomeViewModel.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var result: Double?
    @Published var capturedImage: UIImage?
    
    @Published var isCameraShown: Bool = false
    @Published var isPhotoPickerShown: Bool = false
    
    private weak var model: Model?
    private var cancellables: Set<AnyCancellable> = []
    
    init(model: Model) {
        self.model = model
        self.result = 69
    }
    
    func test() {
        Model().makeTestRequest()
    }
    
    func checkImage() {
        guard let imageData = self.capturedImage?.pngData() else { return }
        
        Model().checkImage(image: imageData)
            .sink(receiveCompletion: {_ in }, receiveValue: { response in
                self.result = response.result
            })
            .store(in: &cancellables)
    }
    
    func dismissCamera() { isCameraShown = false }
    func dismissPhotoPicker() { isPhotoPickerShown = false }
}
