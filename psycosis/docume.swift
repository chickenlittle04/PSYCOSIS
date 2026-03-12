//
//  docume.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import Foundation
internal import Combine

struct Document: Identifiable, Equatable {
    let id: UUID = UUID()
    var title: String
    var text: String
    var lastModified: Date = Date()
}

class DocumentStore: ObservableObject {
    @Published var documents: [Document] = [
        Document(title: "Untitled", text: ""),
        Document(title: "Project Notes", text: "Notes from the project..."),
        Document(title: "Meeting Recap", text: "")
    ]
    @Published var selectedDocument: Document? = nil

    func newDocument() {
        let doc = Document(title: "Untitled", text: "")
        documents.insert(doc, at: 0)
        selectedDocument = doc
    }

    func update(_ document: Document) {
        guard let index = documents.firstIndex(where: { $0.id == document.id }) else { return }
        documents[index] = document
    }
}
