//
//  SettingView.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("設定")
                .font(.largeTitle)
            Text("ここで音声速度やテーマを変更できます。")
        }
        .padding()
        .navigationTitle("設定")
    }
}
