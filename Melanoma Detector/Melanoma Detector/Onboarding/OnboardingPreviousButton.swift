//
//  OnboardingPreviousButton.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

struct OnboardingPreviousButton: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        if viewModel.currentPage != .welcome {
        Button(action: viewModel.previousPage) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10)
                .foregroundColor(.gray)
                .background(
                    Circle()
                        .frame(width: 55, height: 55)
                        .foregroundColor(Color("Main"))
                        .opacity(0.7)
                )
        }
        }
    }
}

struct OnboardingPreviousButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPreviousButton()
            .environmentObject(OnboardingViewModel())
    }
}
