//
//  Melanoma_DetectorApp.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 30.09.22.
//

import SwiftUI

@main
struct Melanoma_DetectorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OnboardingViewModel())
        }
    }
}
