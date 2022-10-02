//
//  HomeView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ResultView()
                PickPhotoButton()
                ScanButton()
                HStack {
                    if let image = viewModel.capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                            .roundedBackground(color: .gray.opacity(0.1))
                    } else {
                        Spacer()
                    }
                    if let resultImage = viewModel.resultImage {
                        Image(uiImage: resultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                            .cornerRadius(20)
                            .roundedBackground(color: .gray.opacity(0.1))
                    } else {
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Melanoma Detector")
            .background(Color("Main").opacity(0.1))
        }
        .fullScreenCover(isPresented: $viewModel.isCameraShown) {
            CameraView()
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $viewModel.isPhotoPickerShown) {
            PhotoPickerView()
                .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel(model: Model()))
    }
}
