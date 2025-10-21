//
//  SelectSection.swift
//  quick-safe-english
//
//  Created by hassie on 2025/10/21.
//

import SwiftUI

struct SelectSectionView: View {
    let selectedMode: PracticeMode
    
    var body: some View {
        List(selectedMode.sections) { section in
            NavigationLink(
                destination: PracticeView(selectedSection: section)
            ) {
                Text(section.title)
            }
        }
        .navigationTitle(selectedMode.name)
    }
}

