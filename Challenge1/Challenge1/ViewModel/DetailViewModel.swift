//
//  DetailViewModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation
import Combine


class DetailViewModel {
    @Published var item: Item
    private var subscribers: Set<AnyCancellable> = []
    let vc: DetailViewController
    let userDefaults = UserDefaults.standard
    var favorites: [String] = [] {
        didSet {
            inFavorite = favorites.contains(item.body.id)
        }
    }
    @Published var inFavorite: Bool = false
    
    
    init(item: Item, vc: DetailViewController) {
        self.item = item
        self.vc = vc
        getFavorites()
        setFavorites()
    }
    
    func getFavorites() {
        favorites = userDefaults.stringArray(forKey: "favorites") ?? []
    }
    
    func setFavorites() {
        vc.$isFavorite.sink { [weak self] isFavorite in
            if isFavorite == true {
                self?.favorites.append(self?.item.body.id ?? "")
                self?.userDefaults.set(self?.favorites, forKey: "favorites")
            } else {
                if let index = self?.favorites.firstIndex(of: self?.item.body.id ?? "") {
                    self?.favorites.remove(at: index)
                    self?.userDefaults.set(self?.favorites, forKey: "favorites")
                }
            }
        }.store(in: &subscribers)
    }
    
    
    
    
}
