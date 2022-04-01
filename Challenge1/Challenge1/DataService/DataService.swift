//
//  DataService.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 29/03/22.
//

import Foundation
import Alamofire
import UIKit


class DataService {
//    TODO: Create protocol DataServiceProtocol
//    TODO: Create baseUrl constant into the constants file.
    
    func getCategory(_ search: String, completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        
        let parameters: Parameters = [
            "limit" : "1",
            "q" : search
        ]
        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(Constants.token)"
//            "Content-Type": "application/X-Access-Token"
                ]
        
        let url = "https://api.mercadolibre.com/sites/MCO/domain_discovery/search"
        let request = AF.request(url,parameters: parameters, headers: headers)
        request.responseDecodable(of: [Category].self) { (response) in
            guard let category = response.value else {
                print(response.error ?? "error")
                print("data fail: \(String(describing: response.response))")
                return completion(.failure(.badDecodable))
            }
            print("data success: \(String(describing: response.data))")
            print(category)
            return completion(.success(category))
            
        }
        
    }
    
    func getTopItems(_ search: String, completion: @escaping (Result<[TopItem], NetworkError>) -> Void) {
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)"
//            "Content-Type": "application/X-Access-Token"
                ]
        
        let url = "https://api.mercadolibre.com/highlights/MCO/category/\(search)"
        let request = AF.request(url, headers: headers)
        request.responseDecodable(of: [TopItem].self) { (response) in
            guard let topList = response.value else {
                print(response.error ?? "error")
                print("data fail: \(String(describing: response.data))")
                return completion(.failure(.badDecodable))
            }
            print("data success: \(String(describing: response.data))")
            print(topList[0])
            return completion(.success(topList))
            
        }
    }
        
        func getItem(_ search: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
        
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Constants.token)"
    //            "Content-Type": "application/X-Access-Token"
                    ]
            
            let url = "https://api.mercadolibre.com/products/\(search)"
            let request = AF.request(url, headers: headers)
            request.responseDecodable(of: Product.self) { (response) in
                guard let product = response.value else {
                    print(response.error ?? "error")
                    print("data fail: \(String(describing: response.data))")
                    return completion(.failure(.badDecodable))
                }
                print("data success: \(String(describing: response.data))")
                print(product)
                return completion(.success(product))
        }
    }
    
    func getProductList(_ search: [TopItem], completion: @escaping (Result<[Item], NetworkError>) -> Void) {
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)"
//            "Content-Type": "application/X-Access-Token"
                ]
        let itemsIds = search.map({ $0.id })
        var url = "https://api.mercadolibre.com/items?ids="
        
        for id in itemsIds {
            url = url + ",\(id)"
        }
        
        let request = AF.request(url, headers: headers)
        request.responseDecodable(of: [Item].self) { (response) in
            guard let products = response.value else {
                print(response.error ?? "error")
                print("data fail: \(String(describing: response.data))")
                return completion(.failure(.badDecodable))
            }
            print("data success: \(String(describing: response.data))")
            print(products[0])
            return completion(.success(products))
        }
    }
    
    func getPrueba(_ search: String, completion: @escaping (Result<[Item], NetworkError>) -> Void) {
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)"
//            "Content-Type": "application/X-Access-Token"
                ]
//        let itemsIds = search.map({ $0.id })
        var url = "https://api.mercadolibre.com/items?ids=\(search)"
        
//        for id in itemsIds {
//            url = url + ",\(id)"
//        }
        
        let request = AF.request(url, headers: headers)
        request.responseDecodable(of: [Item].self) { (response) in
            guard let products = response.value else {
                print(response.error ?? "error")
                print("data fail: \(String(describing: response.data))")
                return completion(.failure(.badDecodable))
            }
            print("data success: \(String(describing: response.data))")
            print(products)
            return completion(.success(products))
        }
    }
}

enum NetworkError: Error {
    case badDecodable
}
