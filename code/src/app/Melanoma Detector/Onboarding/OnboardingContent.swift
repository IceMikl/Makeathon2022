//
//  OnboardingContent.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

struct OnboardingContent: View {
    var page: OnboardingPage
    
    var body: some View {
        VStack {
            Spacer()
            Image(pageImage(page))
                .resizable()
                .frame(width: 300, height: 300)
            Spacer()
            HStack {
                Text(pageText(page))
                    .font(.mainFont(size: 36, weight: .bold))
                    .multilineTextAlignment(.leading)
                .padding(20)
//                .padding(.trailing, 20)
                Spacer()
            }
        }
    }
    
    var pageImage = { (page: OnboardingPage) -> String in
        switch page {
        case .welcome:
            return "OnboardingWelcome"
        case .photo:
            return "OnboardingPhoto"
        case .detection:
            return "OnboardingDetection"
        case .finish:
            return "OnboardingFinish"
        }
    }
    
    var pageText = { (page: OnboardingPage) -> String in
        switch page {
        case .welcome:
            return "Welcome to Melanoma Detection app"
        case .photo:
            return "Capture or upload a photo of patient's skin"
        case .detection:
            return "Get instant results about the probability of melanoma"
        case .finish:
            return "Get started right away"
        }
    }
}

struct OnboardingContent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContent(page: .welcome)
    }
}
