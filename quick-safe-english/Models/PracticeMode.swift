//
//  PracticeMode.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct PracticeMode: Identifiable, Codable {
    var id = UUID()
    let name: String
    let sections: [PracticeSection]
    
    private enum CodingKeys: String, CodingKey {
        case name, sections
    }
}
