//
//  ImageView.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Combine
import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageDownloader

    init(withURL url: String) {
        imageLoader = ImageDownloader(urlString: url)
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage())
            .resizable(resizingMode: .stretch)
    }
}
