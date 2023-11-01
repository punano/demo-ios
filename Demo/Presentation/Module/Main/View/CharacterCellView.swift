//
//  CharacterCellView.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import SwiftUI

struct CharacterCellView: View {

    var item: Character

    var body: some View {
        HStack(spacing: 20) {
            ImageView(withURL: item.thumbnail?.imageUrl ?? "")
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 5) {
                Text(item.name ?? "")
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 18,
                                      weight: .semibold,
                                      design: .monospaced))
            }
            .padding(.leading, 5)
            Spacer()
//            VStack(alignment: .trailing, spacing: 5) {
//                Text(String(item.priceChangePercentage24H ?? 0.0))
//                    .foregroundColor(item.priceChangePercentage24H?.sign == .minus ? Color.red : Color.lightGreen)
//                    .font(Font.system(size: 14)
//            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.vertical, 5)
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCellView(item: .init(id: 0,
                                      name: "Test",
                                      thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e", imageExtension: "jpg"),
                                      comics: nil))
    }
}
