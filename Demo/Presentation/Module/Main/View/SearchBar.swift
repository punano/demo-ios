//
//  SearchBar.swift
//  Demo
//
//  Created by Quan Nguyen on 31/10/2023.
//

import SwiftUI

struct SearchBar: View {

    @State var isLoading: Bool
    @Binding var text: String
    @Binding var isEditing: Bool
    var onClearSearchData: (() -> Void)?

    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                TextField("", text: $text)
                    .background(Color.clear)
                    .foregroundColor(.black)
                    .font(Font.system(size: 18))
                    .placeHolder(Text("Search loaded heroes").font(Font.system(size: 18))
                        .foregroundColor(.black.opacity(0.3)), show: text.isEmpty)
                    .onTapGesture(perform: {
                        isEditing = true
                    })
                if !text.isEmpty {
                    if isLoading {
                        Button(action: {
                            text = .empty
                        }, label: {
                            ActivityIndicator(style: .medium, animate: .constant(true))
                                .configure {
                                    $0.color = .black
                                }
                        })
                        .frame(width: 35, height: 35)
                    } else {
                        Button(action: {
                            text = .empty
                            isEditing = false
                            dismissKeyboard()
                            onClearSearchData?()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                        }).frame(width: 35, height: 35)
                    }
                }
            }.padding(.horizontal)
             .frame(height: 40.0)
        }
    }
}


struct SearchCharacterCellView: View {

    var data: Character

    var body: some View {
        HStack {
            ImageView(withURL: data.thumbnail?.imageUrl ?? "")
                .frame(width: 25.0, height: 25.0)

            Text(data.name ?? "")
                .foregroundColor(Color.black)
                .font(Font.system(size: 16))
        }
        .padding(.vertical, 5)
    }
}
