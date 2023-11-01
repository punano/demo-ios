//
//  DropDown.swift
//  Demo
//
//  Created by Quan Nguyen on 31/10/2023.
//

import SwiftUI

struct DropdownRow: View {
    var character: Character
    var onCharacterSelected: ((_ character: Character) -> Void)?

    var body: some View {
        Button(action: {
            if let onCharacterSelected = self.onCharacterSelected {
                onCharacterSelected(self.character)
            }
        }) {
            SearchCharacterCellView(data: character)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var characters: [Character]
    var onCharacterSelected: ((_ option: Character) -> Void)?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.characters, id: \.id) { character in
                    DropdownRow(character: character, onCharacterSelected: self.onCharacterSelected)
                }
            }
        }
        .frame(height: 250)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
