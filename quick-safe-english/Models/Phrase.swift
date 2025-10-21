//
//  Phrase.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//
import SwiftUI
struct Phrase: Identifiable, Codable {
    var id = UUID()
    let japanese: String
    let english: String
    
    private enum CodingKeys: String, CodingKey {
        case japanese, english
    }
}
