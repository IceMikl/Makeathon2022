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
                Button(action: { viewModel.test() }) {
                    Text("Make test request")
                        .foregroundColor(.white)
                        .roundedBackground(color: Color("Dark Blue"))
                }
                if let image = viewModel.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .cornerRadius(20)
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
