//
//  HomeViewModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation
import Combine

class HomeViewModel {
    
//    MARK: Properties
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
    
//    MARK: Publishers
    @Published var itemsList: [Item] = [] {
        didSet{
            itemCount = itemsList.count
        }
    }
    
    @Published var itemCount: Int = 0
    
    @Published var status: Bool = false

    /**
     Call to the DataService to retrieve the suggested Category
     
     - Parameters:
        - search: Input of the user to begin the search
     */
    func setCategories(_ search: String) {
         DataService.getCategory(search) { result in
            switch result {
            case .failure(let error):
                self.status = true
                print("setCategories: \(error)")
            case .success(let category):
                print("setCategories: \(category[0])")
                self.categories = category
            }
        }
    }
    
    /**
     Retrieve the Top20 Items for the Category suggested
     - Parameters:
        - category: The id of the Category correspondent to a String
     */
    func setTopItemsList(_ category: String) {
        DataService.getTopItems(category) { result in
            switch result {
            case .failure(let error):
                self.status = true
                print("setTopItemsList: \(error)")
            case .success(let topItemContent):
                self.topItemsList = topItemContent.content
            }
        }
    }
    
    /**
     Retrieve of the detail of each Item
     - Parameters:
        - search: An array of TopItem objects
     */
    func setItemsDetail(_ search: [TopItem]) {
        DataService.getTopItemsDetail(search){ result in
            switch result {
            case .failure(let error):
                self.status = true
                print("setProductList: \(error)")
            case .success(let items):
                self.itemsList = items
            }
        }
    }
}
