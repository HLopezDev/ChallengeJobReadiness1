//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 28/03/22.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel! = nil
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var isFavorite: Bool = false
    @Published var item: Item! = nil

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.$item.sink { [weak self] item in
            self?.item = item
        }.store(in: &subscribers)
        
        viewModel.$inFavorite.sink { [weak self] fav in
            self?.isFavorite = fav
        }.store(in: &subscribers)
    }
    
    func setDetailView() {
        
        
        
    }
    
    @IBAction func favTapButton(_ sender: UIButton) {
        isFavorite.toggle()
        if isFavorite {
            favButton.setImage(UIImage(named: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
   
    


 

}
