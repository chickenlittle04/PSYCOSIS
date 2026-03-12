//
//  StatusbarView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

struct StatusBarView: View {
    
    let text: String

    var wordCount: Int {
        text.split(separator: " ").count
    }
    
    var body:some View {
        HStack {
            Text("● Saved")
                .foregroundStyle(.secondary)
            Text("\(wordCount) words")
                .foregroundStyle(.secondary)
            Spacer()
            Text("iCloud ↑")
                .foregroundStyle(.secondary)
            }
        .font(.caption)
        .padding(.horizontal, 16)
        .padding(.vertical,6)
        .background(Color(.systemGray6))
        }

    
    
}

#Preview {
    StatusBarView(text: "hello test tEST tesT")
}
