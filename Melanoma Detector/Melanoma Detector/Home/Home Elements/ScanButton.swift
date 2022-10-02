//
//  ScanButton.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI

struct ScanButton: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        Button(action: { viewModel.isCameraShown = true }) {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                    Text("Scan")
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

struct ScanButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanButton()
            .environmentObject(HomeViewModel(model: Model()))
    }
}
