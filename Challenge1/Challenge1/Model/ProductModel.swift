//
//  ProductModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 29/03/22.
//

import Foundation

struct Product: Decodable, Equatable {
    let id: String
    let name: String
    let price: Int
    let description: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ProductCodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(String.self, forKey: .id)
        price = try values.decode(Int.self, forKey: .price)
        description = try values.decode(String.self, forKey: .description)
    }
}

enum ProductCodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case price = "price"
    case description = "content"
}
