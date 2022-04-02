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
            setTopItemsList(categories[0].categoryId)
        }
    }
    
    var topItemsList: [TopItem] = [] {
        didSet {
           setItemsDetail(topItemsList)
        }
    }
    
    @Published var itemsList: [Item] = [] {
        didSet{
            itemCount = itemsList.count
            print("Cuantos items llegaron al VM \(itemCount)")
        }
    }
    
    @Published var itemCount: Int = 0
    
//    @Published var productList: [Product] = [] {
//        didSet {
//            productCount = productList.count
//        }
//    }
//
//    @Published var productCount: Int = 0
    
    
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
    
    func setTopItemsList(_ category: String) {
        
        data.getTopItems(category) { result in
            switch result {
            case .failure(let error):
                print("setTopItemsList: \(error)")
            case .success(let topItemContent):
                print("setTopItemsList: \(topItemContent)")
                self.topItemsList = topItemContent.content
            }
        }
    }
    
//    func setProductList(_ itemsList: TopItemsContent) {
//
//        let search: String = ""
//        data.getProduct(search) { result in
//            switch result {
//            case .failure(let error):
//                print("setProductList: \(error)")
//            case .success(let products):
//                print("setProductList: \(products)")
////                self.productList = products
//            }
//        }
//    }
    
    func setItemsDetail(_ search: [TopItem]) {
        
        data.getTopItemsDetail(search){ result in
            switch result {
            case .failure(let error):
                print("setProductList: \(error)")
            case .success(let items):
                print("setProductList: \(items)")
                self.itemsList = items
            }
        }
    }
}
