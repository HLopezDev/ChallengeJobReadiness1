//
//  DetailViewModel.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 30/03/22.
//

import Foundation
import Combine


class DetailViewModel {
    
//    MARK: Properties
    private var subscribers: Set<AnyCancellable> = []
    let vc: DetailViewController
    let userDefaults = UserDefaults.standard
    var favorites: Set<String> = []
    
//    MARK: Publishers
    @Published var inFavorite: Bool = false {
        didSet{
            if let id = item?.body.id {
                if inFavorite {
                    persistFavorite(id)
                } else {
                    deleteFavorite(id)
                }
            }
        }
    }
    
    @Published var item: Item! = nil {
        didSet {
            if let id = self.item?.body.id {
                inFavorite = self.favorites.contains(id)
            }
        }
    }
    
//    MARK: Constructor
    init(vc: DetailViewController) {
        self.vc = vc
        getFavorites()
        bindingFavorites()
    }
    
/**
     Retrieve the initial state of the Favorites from UserDefaults.
 */
    func getFavorites() {
        let favs = userDefaults.stringArray(forKey: "favorites") ?? []
        favorites = Set(favs)
        print("Initial Favorites: \(favorites)")
    }
    
    /**
     Save the favorite into UserDefaults
     */
    func persistFavorite(_ id: String) {
        var favs: [String] = []
        if !favorites.contains(id) {
            self.favorites.insert(id)
            favs = Array(self.favorites)
            self.userDefaults.set(favs, forKey: "favorites")
            print("persistFavorite: \(id)")
        }
    }
    
    /**
     Delete the favorite
     */
    func deleteFavorite(_ id: String) {
        var favs: [String] = []
        if favorites.contains(id) {
            self.favorites.remove(id)
            favs = Array(self.favorites)
            self.userDefaults.set(favs, forKey: "favorites")
            print("deleteFavorite: \(id)")
        }
    }
    
    /**
     Subscribe to the Publishers
     */
    func bindingFavorites() {
        vc.$isFavorite.sink { [weak self] favorite in
            self?.inFavorite = favorite
        }.store(in: &subscribers)
    }
}
