//
//  OnboardingViewModel.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    case welcome
    case photo
    case detection
    case finish
}

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = OnboardingPage.welcome
    @Published var isOnboardingFinished = true
    
    func nextPage() {
        if let nextPage = OnboardingPage(rawValue: currentPage.rawValue + 1) {
            currentPage = nextPage
        } else {
            isOnboardingFinished = true
        }
    }
    
    func previousPage() {
        if let previousPage = OnboardingPage(rawValue: currentPage.rawValue - 1) {
            currentPage = previousPage
        }
    }
}
