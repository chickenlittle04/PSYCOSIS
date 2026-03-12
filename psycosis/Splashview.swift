//
//  Splashview.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI


struct Splashview : View {
    var body: some View {
        ZStack {
            Color(.systemGray4)
                .ignoresSafeArea()
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    Splashview()
}
