//
//  ResultView.swift
//  Melanoma Detector
//
//  Created by Murad Talibov on 01.10.22.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if let result = viewModel.result {
                    Text("\(result)%")
                        .font(.mainFont(size: 36, weight: .bold))
                        .foregroundColor(Color("Dark Blue"))
                    Spacer()
                    Text("Melanoma probability")
                        .font(.mainFont(size: 15, weight: .light))
                        .foregroundColor(Color("Dark Blue"))
                } else {
                    Text("No melanoma scans yet")
                        .font(.mainFont(size: 24, weight: .bold))
                        .foregroundColor(Color("Dark Blue"))
                        .opacity(0.6)
                }
            }
            .padding(3)
            .frame(height: 80)
            Spacer()
        }
        .roundedBackground(color: Color("Main"))
        .padding(.horizontal, 10)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
            .environmentObject(HomeViewModel(model: Model()))
    }
}
