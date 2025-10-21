//
//  PracticeViewModel.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

// ViewModels/PracticeViewModel.swift
import Foundation
import AVFoundation

final class PracticeViewModel: ObservableObject {
    @Published var currentPhrase: Phrase?
    @Published var showingEnglish = false
    @Published var didFinishSection = false
    
    private var phrases: [Phrase] = []
    private var currentIndex = 0
    private let synthesizer = AVSpeechSynthesizer()
    
    func load(sectionTitle: String) {
        didFinishSection = false
        showingEnglish = false
        stopSpeaking()
        
        guard let url = Bundle.main.url(forResource: "PracticeData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let modes = try? JSONDecoder().decode([PracticeMode].self, from: data)
        else { return }
        
        // 必要ならモード名で絞る: 今は全モードからタイトル一致のセクションを探す
        let section = modes
            .flatMap { $0.sections }
            .first(where: { $0.title == sectionTitle })
        
        phrases = section?.phrases ?? []
        currentIndex = 0
        currentPhrase = phrases.first
        speakJapanese()
    }
    
    func next() {
        guard !phrases.isEmpty else { return }
        stopSpeaking()
        
        if showingEnglish {
            // 次のフレーズ（日本語）へ。最後なら終了を通知して戻る。
            if currentIndex + 1 < phrases.count {
                currentIndex += 1
                currentPhrase = phrases[currentIndex]
                showingEnglish = false
                speakJapanese()
            } else {
                didFinishSection = true
            }
        } else {
            // 日本語 → 英語
            showingEnglish = true
            speakEnglish()
        }
    }
    
    func prev() {
        guard !phrases.isEmpty else { return }
        stopSpeaking()
        
        // どの状態からでも「1つ前のフレーズ（日本語）」へ
        if currentIndex > 0 {
            currentIndex -= 1
            currentPhrase = phrases[currentIndex]
            showingEnglish = false
            speakJapanese()
        } else {
            // 先頭ならそのまま日本語の先頭を読み上げ直し
            showingEnglish = false
            speakJapanese()
        }
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    private let jaVolume: Float = 1.0   // 0.0 ... 1.0
    private let enVolume: Float = 0.85  // 英語が大きく感じるなら下げる/小さければ上げる
    private let jaRate: Float = AVSpeechUtteranceDefaultSpeechRate
    private let enRate: Float = AVSpeechUtteranceDefaultSpeechRate
    
    private func speakJapanese() {
        guard let p = currentPhrase else { return }
        let u = AVSpeechUtterance(string: p.japanese)
        u.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        u.volume = jaVolume
        u.rate   = jaRate
        synthesizer.speak(u)
    }
    
    private func speakEnglish() {
        guard let p = currentPhrase else { return }
        let u = AVSpeechUtterance(string: p.english)
        u.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        u.volume = enVolume
        u.rate   = enRate
        synthesizer.speak(u)
    }
}
