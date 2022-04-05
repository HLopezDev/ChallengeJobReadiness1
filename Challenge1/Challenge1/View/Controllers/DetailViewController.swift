//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 28/03/22.
//

import UIKit
import Combine
import AlamofireImage

class DetailViewController: UIViewController {
    
//    MARK: Properties
    var viewModel: DetailViewModel! = nil
    private var subscribers: Set<AnyCancellable> = []
    
//    MARK: Publishers
    @Published var isFavorite: Bool = false {
        didSet {
            print("New Value isFavorite: \(isFavorite)")
        }
    }
    @Published var item: Item! = nil

//    MARK: Oulets
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favImageButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDetailView()
    }
    
//    MARK: Actions - Received the input of the user and set the Favorites button in consequence.
    @IBAction func favImageButtonTapped(_ sender: UIButton) {
        isFavorite.toggle()
        setFavoriteButton()
//        print("favImageButtonTapped \(isFavorite)")
    }
    
    @IBAction func favTapButton(_ sender: UIButton) {
        isFavorite.toggle()
        setFavoriteButton()
//        print("favTapButton \(isFavorite)")
    }
}

// MARK: Extension - Add custom methods
extension DetailViewController {
    
    /**
     Set the image for the state of the Favorite Button
     */
    func setFavoriteButton() {
        if isFavorite {
            favImageButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("setImage \(isFavorite)")
        } else {
            favImageButton.setImage(UIImage(systemName: "heart"), for: .normal)
            print("setImage \(isFavorite)")
        }
    }
    
    /**
         Suscribe to Publishers of the DetailViewModel
     */
    func bindViewModel() {
        viewModel.$item.sink { [weak self] item in
            self?.item = item
        }.store(in: &subscribers)
        
        viewModel.$inFavorite.sink { [weak self] fav in
            self?.isFavorite = fav
        }.store(in: &subscribers)
    }
    
    /**
         Set the initial state of the view
     */
    func setDetailView() {
        titleLabel.text = item.body.title
        priceLabel.text = customFormatter(item.body.price)
        let url = URL(string: item.body.pictures.first?.secure_url ?? "")!
        itemImage.af.setImage(withURL: url)
        cityLabel.text = item.body.seller_address.city.name
        stateLabel.text = item.body.seller_address.state.name
        countryLabel.text = item.body.seller_address.country.name
        setFavoriteButton()
    }
    
    /**
         Set the price format to .currency
     */
    func customFormatter(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: number))
        return result ?? "0"
    }
}
