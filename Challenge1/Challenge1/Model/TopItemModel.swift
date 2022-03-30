//
//  TopItem.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation

struct TopItem: Decodable, Equatable {
    let position: Int
    let id: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: TopItemCodingKeys.self)
        position = try values.decode(Int.self, forKey: .position)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
    }
}

enum TopItemCodingKeys: String, CodingKey {
    case position = "position"
    case id = "id"
    case type = "type"
}




