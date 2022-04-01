//
//  HomeViewModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    var data: DataService!
    
    var categories: [Category] = [] {
        didSet {
            setItemsList(categories[0].categoryId)
        }
    }
    
    var itemsList: [TopItem] = [] {
        didSet {
            setProductList(itemsList)
        }
    }
    
    @Published var productList: [Product] = [] {
        didSet {
            productCount = productList.count
        }
    }
    
    @Published var productCount: Int = 0
    
    
    init(dataSource: DataService = DataService()) {
        self.data = dataSource
    }
    
    func setCategories(_ search: String) {
        
         data.getCategory(search) { result in
            switch result {
            case .failure(let error):
                print("setCategories: \(error)")
            case .success(let category):
                print("setCategories: \(category[0])")
                self.categories = category
            }
        }
    }
    
    func setItemsList(_ category: String) {
        
        data.getTopItems(category) { result in
            switch result {
            case .failure(let error):
                print("setItemsList: \(error)")
            case .success(let topItem):
                print("setItemsList: \(topItem)")
                self.itemsList = topItem
            }
        }
    }
    
    func setProductList(_ itemsList: [TopItem]) {
        
        data.getProductList(itemsList) { result in
            switch result {
            case .failure(let error):
                print("setProductList: \(error)")
            case .success(let products):
                print("setProductList: \(products[0])")
//                self.productList = products
            }
        }
    }
    
    func pruebaConexion(_ search: String) {
        
        data.getPrueba(search) { result in
            switch result {
            case .failure(let error):
                print("setProductList: \(error)")
            case .success(let products):
                print("setProductList: \(products)")
            }
        }
    }
}
