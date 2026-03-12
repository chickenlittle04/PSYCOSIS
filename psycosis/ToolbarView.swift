//
// ToolbarView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

  struct ToolbarView: View {
      var body: some View {
          HStack(spacing: 16) {
              // Style picker
              Menu("Body") {
                  Button("Title", action: {})
                  Button("Heading", action: {})
                  Button("Body", action: {})
              }
              .buttonStyle(.glass)
              .frame(width: 80)

              Divider().frame(height: 20)

              // Formatting buttons
              Button(action: {}) { Text("B").bold() }
              Button(action: {}) { Text("I").italic() }
              Button(action: {}) { Text("U").underline() }

              Spacer()
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
          .background(Color(.systemGray6))
      }
  }


#Preview {
    ToolbarView()
}
