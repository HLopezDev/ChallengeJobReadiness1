//
//  HomeTableViewController.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 28/03/22.
//

import UIKit
import Combine

class HomeTableViewController: UITableViewController {
    let searchController = UISearchController()
    let viewModel = HomeViewModel()
    let vcDetail = DetailViewController()
    private var subscribers: Set<AnyCancellable> = []
    
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
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        print("Home view corre")
        registerTableViewCells()
        bindViewModel()
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func registerTableViewCells() {
        let productCell = UINib(nibName: "HomeTableViewCell",bundle: nil)
        self.homeTableView.register(productCell, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemCount
//        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = homeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
//        HomeTableViewCell
////        let cell = setCells(indexPath)
       let cell = setCells(indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemList[indexPath.row]
        vcDetail.viewModel = DetailViewModel(item: item, vc: vcDetail)
        print("Send it to Detail: \(item)")
        self.navigationController?.pushViewController(vcDetail, animated: true)
    }
}

extension HomeTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            
            print("Y la busqueda es \(searchString)")
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            
            viewModel.setCategories(searchString)
            
            homeTableView.reloadData()
            print("search button click: \(searchString)")
        }
    }
        
    func bindViewModel() {
        viewModel.$itemsList.sink { [weak self] list in
            self?.itemList = list
        }.store(in: &subscribers)
        viewModel.$itemCount.sink { [weak self] count in
            self?.itemCount = count
        }.store(in: &subscribers)
        
        print("bindVM se ejecuta")
        
    }
    
    
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
        //        cell.itemImage.image =
        
        return cell
    }
    
    func customFormatter(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: number))
        return result ?? "0"
    }
        
    
    
}
// in view controller 1
//let vc2 = ViewController2()
//vc2.viewModel = self.viewModel.viewModel2

// el VM2 es instanciado por el viewmodel 1 y en el view controller 1 se lo pasas al viewcontroller 2 asignandole la variable.
//https://stackoverflow.com/questions/43815549/ios-how-to-pass-a-model-from-view-model-to-view-model-using-mvvm
