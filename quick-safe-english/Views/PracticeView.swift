//
//  PracticeView.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct PracticeView: View {
    let selectedSection: PracticeSection
    @StateObject private var viewModel = PracticeViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(viewModel.showingEnglish
                     ? (viewModel.currentPhrase?.english ?? "")
                     : (viewModel.currentPhrase?.japanese ?? ""))
                Text("\(selectedSection.title)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { location in
                // 位置付きタップ（iOS17+）
                if location.x < geo.size.width * 0.5 {
                    viewModel.prev()   // 左半分: 前へ（日本語に戻る→前フレーズ日本語）
                } else {
                    viewModel.next()         // 右半分: 日本語→英語→次の日本語
                }
            }
        }
        .onAppear {
            viewModel.load(sectionTitle: selectedSection.title)
        }
    }
}
