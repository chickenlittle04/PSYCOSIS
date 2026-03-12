//
//  psycosisApp.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI

@main
struct psycosisApp: App {
    @StateObject private var store = DocumentStore()

    var body: some Scene {
        // WindowGroup works on all devices
        WindowGroup {
            MainView()
                .environmentObject(store)
        }
    }
}
