//
//  PracticeView.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct SelectModeView: View {
    @State private var modes: [PracticeMode] = []

    var body: some View {
        NavigationView {
            List(modes) {
                mode in
                NavigationLink(
                    destination: SelectSectionView(selectedMode: mode)
                ) {
                    Text(mode.name)
                }
            }
            .navigationTitle("モード選択")
            .onAppear {
                loadData()
            }

        }
    }
    
    private func loadData() {
        if let url = Bundle.main.url(forResource: "PracticeData", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([PracticeMode].self, from: data) {
            modes = decoded
        } else {
            print("PracticeData.json読み込み失敗")
        }
    }
}
