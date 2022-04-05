//
//  ProductModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 29/03/22.
//

import Foundation

struct Product: Decodable {
    let id: String
    let name: String
    let pictures: [ProductPictures]
    let buy_box_winner: BuyBox
    let short_description: ProductDescription
}

struct ProductPictures: Decodable {
    let url: String
}

struct ProductDescription: Decodable {
    let content: String
}

struct BuyBox: Decodable {
    let price: Int
    let warranty: String
    let condition: String
    let seller_address: SellerAddress
}
