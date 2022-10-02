//
//  PickPhotoButton.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI

struct PickPhotoButton: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        Button(action: { viewModel.isPhotoPickerShown = true }) {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                        .foregroundColor(.white)
                    Text("Select photo")
                        .font(.mainFont(size: 18, weight: .bold))
                    .foregroundColor(.white)
                }
                Spacer()
            }
            .roundedBackground(color: Color("Dark Blue"))
            .padding(.horizontal, 10)
        }
    }
}

struct PickPhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        PickPhotoButton()
            .environmentObject(HomeViewModel(model: Model()))
    }
}
