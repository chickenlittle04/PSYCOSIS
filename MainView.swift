//
//  MainView.swift
//  psycosis
//
//  Created by Abdallah Hussein on 3/11/26.
//

import SwiftUI
   
  struct MainView: View {
      var body: some View {
          NavigationSplitView {
              SidebarView()
          } detail: {
              EditorView()
          }
      }
  }

  #Preview {
      MainView()
          .environmentObject(DocumentStore())
  }
