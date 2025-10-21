//
//  PracticeSection.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//
import SwiftUI
struct PracticeSection: Identifiable, Codable {
    var id = UUID()
    let title: String
    let phrases: [Phrase]
    
    private enum CodingKeys: String, CodingKey {
        case title, phrases
    }
}
