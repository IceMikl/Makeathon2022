//
//  OnboardingNextButton.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

struct OnboardingNextButton: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Button(action: viewModel.nextPage) {
            if viewModel.currentPage != .finish {
                Image(systemName: "chevron.right")
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
                    .frame(width: 55, height: 55)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(Color("Main"))
                        .frame(width: 130, height: 55)
                        .opacity(0.7)
                    Text("Get started")
                        .font(.mainFont(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct OnboardingNextButton_Previews: PreviewProvider {
    static var viewModel = OnboardingViewModel()
    
    static var previews: some View {
        viewModel.currentPage = .finish
        return OnboardingNextButton()
            .environmentObject(viewModel)
    }
}
