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
    @Published var inFavorite: Bool = false
    @Published var item: Item! = nil {
        didSet {
            if let id = self.item?.body.id {
                inFavorite = self.favorites.contains(id)
            }
            setFavorites()
        }
    }
    
//    MARK: Constructor
    init(vc: DetailViewController) {
        self.vc = vc
        getFavorites()
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
    Observe and persist the Favorites
 */
    func setFavorites() {
        let id = item.body.id
        let exist = favorites.contains(id)
        var favs: [String] = []
        vc.$isFavorite.sink { [ weak self ] isFavorite in
            if isFavorite == true {
                self?.favorites.insert(id)
                favs = Array(self?.favorites ?? [])
                print("Favorite add VM: \(id)")
                print("Favorites after add VM \(String(describing: self?.favorites))")
                self?.userDefaults.set(favs, forKey: "favorites")
            } else {
                if exist {
                    self?.favorites.remove(id)
                    favs = Array(self?.favorites ?? [])
                    self?.userDefaults.set(favs, forKey: "favorites")
                    print("Remove from favorites VM: \(id)")
                    print("Favorites after remove VM: \(favs)")
                }
            }
        }.store(in: &subscribers)
    }
}
