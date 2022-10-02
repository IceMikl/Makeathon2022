//
//  HomeViewModel.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var result: String?
    @Published var capturedImage: UIImage?
    @Published var resultImage: UIImage?
    
    @Published var isCameraShown: Bool = false
    @Published var isPhotoPickerShown: Bool = false
    
    private weak var model: Model?
    private var cancellables: Set<AnyCancellable> = []
    
    init(model: Model) {
        self.model = model
    }
    
    func test() {
        Model().makeTestRequest()
            .sink(receiveCompletion: { _ in }, receiveValue: { response in
                print(response ?? "Test response is empty")
            })
            .store(in: &cancellables)
    }
    
    func checkImage() {
        guard let imageData = self.capturedImage?.pngData() else { return }
        
        Model().checkImage(image: imageData)
            .sink(receiveCompletion: {_ in }, receiveValue: { response in
                if let imageData = response.imageData {
                    if let image = UIImage(data: imageData) {
                        self.resultImage = image
                        self.result = response.probability
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func dismissCamera() { isCameraShown = false }
    func dismissPhotoPicker() { isPhotoPickerShown = false }
}
