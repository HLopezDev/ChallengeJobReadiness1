//
//  ItemModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 31/03/22.
//

import Foundation

struct Item: Decodable {
    let body: Body
}

struct Body: Decodable {
    let id: String
    let title: String
    let price: Int
    let secure_thumbnail: String
    let seller_address: SellerAddress
    let descriptions: [String]
    let date_created: String
    let pictures: [APicture]
}

struct SellerAddress: Decodable {
    let city: City
    let state: State
    let country: Country
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

struct ItemPictures: Decodable {
    let pictures: [APicture]
}

struct APicture: Decodable {
    let secure_url: String
}
