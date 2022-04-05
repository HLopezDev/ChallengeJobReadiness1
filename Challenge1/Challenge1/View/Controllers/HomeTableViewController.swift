//
//  HomeTableViewController.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 28/03/22.
//

import UIKit
import Combine
import AlamofireImage

class HomeTableViewController: UITableViewController {
    
//    MARK: Properties
    let searchController = UISearchController()
    let viewModel = HomeViewModel()
    let vcDetail = DetailViewController()
    private var subscribers: Set<AnyCancellable> = []
    
//    MARK: Publishers
    @Published var itemList: [Item] = [] {
        didSet{
            print("nuevo valor itemList HomeVC: ")
            print(itemList)
        }
    }
    
    @Published var itemCount: Int = 0 {
        didSet {
            print("Nuevo valor itemCount HomeVC: ")
            print(itemCount)
            tableView.reloadData()
        }
    }
    
//    MARK: Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerTableViewCells()
        bindViewModel()
        vcDetail.viewModel = DetailViewModel(vc: vcDetail)
    }
    
    func registerTableViewCells() {
        let productCell = UINib(nibName: "HomeTableViewCell",bundle: nil)
        self.homeTableView.register(productCell, forCellReuseIdentifier: "cell")
    }

//    MARK: Methods of the class
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = setCells(indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemList[indexPath.row]
        vcDetail.viewModel.item = item
        print("Send it to Detail: \(item)")
        self.navigationController?.pushViewController(vcDetail, animated: true)
    }
}

// MARK: Extension - Implementation of custom methods.
extension HomeTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    /**
     SetUp the appearance of the UI
     */
    func setUpUI() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "CustomNavbarColor")
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        Method no implemented in this version
        }
    
    /**
     Request for a search with the input of the user.
     - Parameters:
        - searchBar: receive an instance of the searchBar and capture the input of the user
                    to make the request to the remote server.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            viewModel.setCategories(searchString)
            homeTableView.reloadData()
            print("search button click: \(searchString)")
        }
    }
        
    /**
     Subscribe to Publishers in the HomeViewModel
     */
    func bindViewModel() {
        viewModel.$itemsList.sink { [weak self] list in
            self?.itemList = list
        }.store(in: &subscribers)
        viewModel.$itemCount.sink { [weak self] count in
            self?.itemCount = count
        }.store(in: &subscribers)
    }
    
    /**
     Map each Item information into the views of the cell
        - Parameters:
           - index: The position for the object to map
     */
    func setCells(_ index: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell", for: index) as!
        HomeTableViewCell
        cell.nameLabel.text = itemList[index.row].body.title
        cell.priceLabel.text = customFormatter(itemList[index.row].body.price)
        cell.dateLabel.text = String(
            ISO8601DateFormatter()
                .date(from: itemList[index.row].body.date_created)?
                .formatted(date: .abbreviated, time: .omitted) ?? ""
        )
        cell.cityLabel.text = itemList[index.row].body.seller_address.city.name
        let url = URL(string: itemList[index.row].body.secure_thumbnail)!
        cell.itemImage.af.setImage(withURL: url)
        return cell
    }
    
    /**
     Format the number into a .currency format and return a String
     */
    func customFormatter(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: number))
        return result ?? "0"
    }
}
