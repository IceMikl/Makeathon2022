//
//  OnboardingView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            TabView(selection: $viewModel.currentPage) {
                OnboardingContent(page: .welcome)
                    .tag(OnboardingPage.welcome)
                OnboardingContent(page: .photo)
                    .tag(OnboardingPage.photo)
                OnboardingContent(page: .detection)
                    .tag(OnboardingPage.detection)
                OnboardingContent(page: .finish)
                    .tag(OnboardingPage.finish)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//                .animation(.linear(duration: 0.3))
//                .transition(.slide)
                .padding(.bottom, 50)
            HStack {
                OnboardingPreviousButton()
                    .padding(.leading, 40)
                Spacer()
                OnboardingNextButton()
                    .padding(.trailing, 20)
            }
        }
        .background(Color("Main").opacity(0.1))
        .animation(.linear(duration: 0.2))
        .transition(.slide)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var viewModel = OnboardingViewModel()
    
    static var previews: some View {
        viewModel.currentPage = .welcome
        return OnboardingView()
            .environmentObject(viewModel)
    }
}
