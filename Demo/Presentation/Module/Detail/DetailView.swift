//
//  DetailView.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import SwiftUI

struct DetailView: View {

    enum Constant {
        static let spacing: CGFloat = 6
    }

    var character: Character?

    init(item: Character? = nil) {
        self.character = item
    }

    var body: some View {
        ZStack {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    ImageView(withURL: character?.thumbnail?.imageUrl ?? "")
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    Text(character?.name ?? "")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 21))
                        .fontWeight(.semibold)
                    Divider()
                        .background(Color.white.opacity(0.5))
                    Text("Appears in")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    LazyVStack(spacing: Constant.spacing){
                        ForEach(character?.comics?.items ?? [], id: \.name) { comic  in
                            Text(comic.name ?? "")
                        }
                    }
                }
                .padding(.top)
            }
        }
        .navigationBarTitle("Character Detail", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: Character.mock)
    }
}
