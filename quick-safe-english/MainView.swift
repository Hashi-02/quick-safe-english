//
//  MainView.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct MainView : View {
    var body: some View {
        VStack(spacing:20) {
            Text("QuickSafe English").font(.largeTitle)
            
            NavigationLink( destination: SelectModeView()){
                Label("練習画面", systemImage: "figure.boxing")
            }

            NavigationLink(destination: SettingsView()) {
                Label("設定", systemImage: "gear")
            }
        }
        .navigationTitle("ホーム")
        .padding()
    }
}
