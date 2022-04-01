//
//  ItemModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 31/03/22.
//

import Foundation

struct Body: Decodable {
    let id: String
    let title: String
    let price: Int
    let secure_thumbnail: String
    let seller_address: SellerAddress
    let descriptions: [String]
    
}

struct City: Decodable {
    let name: String
}

struct State: Decodable {
    let name: String
}

struct Country: Decodable {
    let name: String
    let id: String
}
struct SellerAddress: Decodable {
    let city: City
    let state: State
    let country: Country
}

struct Item: Decodable {
    let body: Body
//    let id: String
//    let name: String
//    let price: Int
//    let description: String
//    let date: String
//    let cityName: String
//    let stateName: String
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: ItemCodingKeys.self)
//        let body = try values.nestedContainer(keyedBy: ItemCodingKeys.self, forKey: .body.key)
//        name = try body.decode(String.self, forKey: .name.key)
//        id = try body.decode(String.self, forKey: .id.key)
//        price = try body.decode(Int.self, forKey: .price.key)
//        description = try body.decode(String.self, forKey: .description.key)
//        let address = try body.nestedContainer(keyedBy: ItemCodingKeys.self, forKey: .sellerAddress.key)
//        let city = try address.nestedContainer(keyedBy: ItemCodingKeys.self, forKey: .city.key)
//        cityName = try city.decode(String.self, forKey: .cityName)
//        let state = try address.nestedContainer(keyedBy: ItemCodingKeys.self, forKey: .state.key)
//        stateName = try state.decode(String.self, forKey: .stateName.key)
//
//    }
//}
//
//enum ItemCodingKeys: String, CodingKey {
//
////    case id = "id"
////    case name = "title"
////    case price = "price"
////    case description = "content"
////    case date = "date"
////    case city = "city"
////    case body = "body"
////    case cityName = "name"
////    case sellerAddress = "seller_address"
////    case state = "state"
////    case stateName = "name"
//
//    case id
//    case name
//    case price
//    case description
//    case date
//    case city
//    case body
//    case cityName
//    case sellerAddress
//    case state
//    case stateName
//
//    var key: String {
//        switch self {
//        case .id:
//            return "id"
//        case .name:
//            return "title"
//        case .price:
//            return "price"
//        case .description:
//            return "content"
//        case .date:
//            return "date"
//        case .city:
//            return "city"
//        case .body:
//            return "body"
//        case .cityName:
//            return "name"
//        case .sellerAddress:
//            return "seller_address"
//        case .state:
//            return "state"
//        case .stateName:
//            return "name"
//        }
//    }
}

