//
//  CategoryModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation

struct Category: Decodable, Equatable {
    
    let name: String
    let categoryId: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CategoryCodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        categoryId = try values.decode(String.self, forKey: .categoryId)
    }
}

enum CategoryCodingKeys: String, CodingKey {
    case name = "category_name"
    case categoryId = "category_id"
}
