//
//  ContentView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var onboarding: OnboardingViewModel
    
    var body: some View {
        if onboarding.isOnboardingFinished {
            HomeView()
                .environmentObject(HomeViewModel(model: Model()))
        } else {
            OnboardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OnboardingViewModel())
    }
}
