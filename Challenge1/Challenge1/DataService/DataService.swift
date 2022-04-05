//
//  DataService.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 29/03/22.
//

import Foundation
import Alamofire
import UIKit


class DataService: DataServiceProtocol {
    
/**
 Retrieve Category from the server
 - Parameters:
    - search: Receive an String input for the user.
 */
    static func getCategory(_ search: String, completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        let parameters: Parameters = [
            "limit" : "1",
            "q" : search
        ]
        let headers: HTTPHeaders = []
        let url = Constants.endpointCategory
        let request = AF.request(url,parameters: parameters, headers: headers)
        request.responseDecodable(of: [Category].self) { (response) in
            guard let category = response.value else {
                print(response.error ?? "error")
                print("getCategory data fail: \(String(describing: response.response))")
                return completion(.failure(.badDecodable))
            }
//            print("getCategory data success: \(String(describing: response.data))")
//            print(category)
            return completion(.success(category))
        }
    }
    
    /**
     Retrieve the Top20 Items for the Category required.
     - Parameters:
        - search: Take a Category Id as String
     */
    static func getTopItems(_ search: String, completion: @escaping (Result<TopItemsContent, NetworkError>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)"
                ]
        let url = Constants.endpointTopItems + search
        let request = AF.request(url, headers: headers)
        request.responseDecodable(of: TopItemsContent.self) { (response) in
            guard let topList = response.value else {
                print(response.error ?? "error")
                print("getTopItems data fail: \(String(describing: response.data))")
                return completion(.failure(.badDecodable))
            }
//            print("getTopItems data success: \(String(describing: response.data))")
//            print(topList)
            return completion(.success(topList))
        }
    }
        
    /**
     Retrieve Product detail from server
     - Parameters:
        - search: Receive a Product id as String.
     */
    static func getProduct(_ search: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Constants.token)"
                    ]
        let url = Constants.endpointGetProduct + search
            let request = AF.request(url, headers: headers)
            request.responseDecodable(of: Product.self) { (response) in
                guard let product = response.value else {
                    print(response.error ?? "error")
                    print("getProduct data fail: \(String(describing: response.data))")
                    return completion(.failure(.badDecodable))
                }
//                print("getProduct data success: \(String(describing: response.data))")
//                print(product)
                return completion(.success(product))
        }
    }
    
    /**
     Retrieve Items detail from server. Is a Multiget.
     - Parameters:
        - search: Receive a list of TopItem objects and return an array of type Item.
     */
    static func getTopItemsDetail(_ search: [TopItem], completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)"
                ]
        let itemsIds = search.map({ $0.id })
        var url = Constants.endpintGetItemsDetail
        for id in itemsIds {
            url = url + ",\(id)"
        }
        let request = AF.request(url, headers: headers)
        request.responseDecodable(of: [Item].self) { (response) in
            guard let items = response.value else {
                print(response.error ?? "error")
                print("getTopItemsDetail failed: \(String(describing: response.data))")
                return completion(.failure(.badDecodable))
            }
//            print("getTopItemsDetail data success: \(String(describing: response.data))")
//            print(items[0])
            return completion(.success(items))
        }
    }
}

enum NetworkError: Error {
    case badDecodable
}
