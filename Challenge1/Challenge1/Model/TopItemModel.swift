//
//  TopItem.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation

struct TopItemsContent: Decodable {
    let content: [TopItem]
}

struct TopItem: Decodable, Equatable {
    let position: Int
    let id: String
    let type: String
}

enum TopItemCodingKeys: String, CodingKey {
    case position = "position"
    case id = "id"
    case type = "type"
    case content = "content"
}
