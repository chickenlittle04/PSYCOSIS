//
//  ContentView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: psycosisDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(psycosisDocument()))
}
