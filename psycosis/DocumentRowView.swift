//
//  DocumentRowView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//


import SwiftUI

struct DocumentRowView: View {
    let title: String
    let date: String

    var body: some View {
        HStack {
            Image(systemName: "doc")
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body)
                Text(date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
