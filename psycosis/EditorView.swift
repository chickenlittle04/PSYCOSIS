//
//  EditorView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

struct EditorView: View {
    @EnvironmentObject var store: DocumentStore
    @State private var text = ""

    var body: some View {
        if store.selectedDocument != nil {
            VStack(spacing: 0) {
                ToolbarView()

                ScrollView {
                    TextEditor(text: $text)
                        .frame(minHeight: 900)
                        .padding(40)
                        .background(Color.white)
                        .cornerRadius(4)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(40)
                }
                .background(Color(.systemGray5))

                StatusBarView(text: text)
            }
            // When user typesv save back to the store
            .onChange(of: text) { newText in
                guard var doc = store.selectedDocument else { return }
                doc.text = newText
                store.update(doc)
                store.selectedDocument = doc
            }
            // When a different document is selected load its text
            .onChange(of: store.selectedDocument?.id) { _ in
                text = store.selectedDocument?.text ?? ""
            }
            // When the editor first appears load the document text
            .onAppear {
                text = store.selectedDocument?.text ?? ""
            }
        } else {
            VStack {
                Spacer()
                Text("Select or create a document")
                    .foregroundStyle(.secondary)
                    .font(.title3)
                Spacer()
            }
        }
    }
}

#Preview {
    EditorView()
        .environmentObject(DocumentStore())
}
