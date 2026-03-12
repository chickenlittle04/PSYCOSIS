//
//  SidebarView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var store: DocumentStore

    var body: some View {
        VStack(spacing: 0) {

            // Document list driven by real data from the store
            List(store.documents) { doc in
                DocumentRowView(
                    title: doc.title,
                    date: doc.lastModified.formatted(date: .abbreviated, time: .omitted)
                )
                .onTapGesture {
                    store.selectedDocument = doc
                }
            }
            .listStyle(.sidebar)

            // New Document button pinned to bottom
            Button(action: { store.newDocument() }) {
                Label("New Document", systemImage: "plus")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderless)
        }
    }
}

#Preview {
    SidebarView()
        .environmentObject(DocumentStore())
}
