//
//  PracticeViewModel.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import Foundation
import AVFoundation

final class PracticeViewModel: ObservableObject {
    @Published var currentPhrase: Phrase?
    @Published var showingEnglish = false
    private var phrases: [Phrase] = []
    private var currentIndex = 0
    private let synthesizer = AVSpeechSynthesizer()
    
    // JSONからセクションのフレーズをロード
    func load(sectionTitle: String) {
        guard let url = Bundle.main.url(forResource: "PracticeData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let modes = try? JSONDecoder().decode([PracticeMode].self, from: data)
        else {
            print("データ読み込み失敗")
            return
        }
        
        // Normalモード内の対象セクションを取得
        if let section = modes.first?.sections.first(where: { $0.title == sectionTitle }) {
            self.phrases = section.phrases
            self.currentIndex = 0
            self.currentPhrase = phrases.first
            speakJapanese()
        }
    }
    
    func next() {
        guard !phrases.isEmpty else { return }
        
        if showingEnglish {
            // 英語表示中 → 次の日本語へ
            showingEnglish = false
            currentIndex = (currentIndex + 1) % phrases.count
            currentPhrase = phrases[currentIndex]
            speakJapanese()
        } else {
            // 日本語表示中 → 英語へ
            showingEnglish = true
            speakEnglish()
        }
    }
    
    func prev() {
        guard !phrases.isEmpty else { return }
        
        if showingEnglish {
            // 英語→日本語に戻る
            showingEnglish = false
            speakJapanese()
        } else {
            // 前の日本語フレーズへ
            currentIndex = (currentIndex - 1 + phrases.count) % phrases.count
            currentPhrase = phrases[currentIndex]
            speakJapanese()
        }
    }

    
    private func speakJapanese() {
        guard let phrase = currentPhrase else { return }
        let utterance = AVSpeechUtterance(string: phrase.japanese)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        synthesizer.speak(utterance)
    }
    
    private func speakEnglish() {
        guard let phrase = currentPhrase else { return }
        let utterance = AVSpeechUtterance(string: phrase.english)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}
