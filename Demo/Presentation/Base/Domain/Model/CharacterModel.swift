//
//  CharacterModel.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation

struct ResultWrapper: Codable {
    let code: Int?
    let data: CharacterWrapper?
}

struct CharacterWrapper: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail?
    let comics: ComicWrapper?
    
    static var mock: Character {
        return .init(id: nil,
                     name: "Test",
                     thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/60/52695285d6e7e",
                                      imageExtension: "jpg"),
                     comics: .init(available: 0, collectionURI: "", items: []))
    }
}

struct Thumbnail: Codable {
    let path: String?
    let imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

extension Thumbnail {
    var imageUrl: String {
        guard let path, let imageExtension else {
            return .empty
        }
        return "\(path).\(imageExtension)"
    }
}

struct ComicWrapper: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Comic]?
}

struct Comic: Codable {
    let resourceURI: String?
    let name: String?
}
