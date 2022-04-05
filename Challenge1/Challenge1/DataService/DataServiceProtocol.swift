//
//  DataServiceProtocol.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 4/04/22.
//

import Foundation
/**
 Provides a common inteface for the data retrieving.
 */
protocol DataServiceProtocol {
    
    static func getCategory(_ search: String, completion: @escaping (Result<[Category], NetworkError>) -> Void)
    
    static func getTopItems(_ search: String, completion: @escaping (Result<TopItemsContent, NetworkError>) -> Void)
    
    static func getProduct(_ search: String, completion: @escaping (Result<Product, NetworkError>) -> Void)
    
    static func getTopItemsDetail(_ search: [TopItem], completion: @escaping (Result<[Item], NetworkError>) -> Void)
}
