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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(viewModel.showingEnglish
                     ? (viewModel.currentPhrase?.english ?? "")
                     : (viewModel.currentPhrase?.japanese ?? ""))
                Text(selectedSection.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture { location in
                // 左半分=前へ / 右半分=次へ（スワイプは使わない）
                if location.x < geo.size.width / 2 {
                    viewModel.prev()
                } else {
                    viewModel.next()
                }
            }
        }
        .onAppear {
            viewModel.load(sectionTitle: selectedSection.title)
        }
        .onDisappear {
            viewModel.stopSpeaking() // 画面離脱時に音声停止
        }
        .onChange(of: viewModel.didFinishSection) { finished in
            if finished {
                viewModel.stopSpeaking()
                dismiss() // セクション完了でセクション選択画面に戻る
            }
        }
    }
}

