//
//  CountriesAndCategoriesSelectionViewController.swift
//  NewsApp
//
//  Created by Ahmed on 16/02/2022.
//

import UIKit

protocol CountriesAndCategoriesSelectionViewProtocol : LoaderViewProtocol, AlertHandlerViewProtocol {
    func reloadCollectionView()
    func reloadTableView()
    func reloadTableRow(at index: Int)

}

class CountriesAndCategoriesSelectionViewController: UIViewController {

    //MARK: - Vars
    var presenter: CountriesAndCategoriesSelectionPresenterProtocol!
    
    //MARK: - Outlets
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoriesTableViewStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        updateView()
    }
    
    //MARK: - IBActions
    @IBAction func confirmBtn(_ sender: Any) {
        checkCategoriesNumber()
    }
    
    
    //MARK: - Helper Functions
    
    func checkCategoriesNumber() {
        let categories = presenter.getSelectedCategories
        if categories.count == 3 {
            cacheDataThenPushToNextScreen(selectedCategories: categories)
        } else {
            self.showAlert(with:"Please Just Select 3 Categories", title: .error)
        }
    }
    func cacheDataThenPushToNextScreen(selectedCategories: [String]) {
        let selectedCountry = presenter.getSelectedCountry
        let userData = UserData(country: selectedCountry, categories: selectedCategories)
        CacheService.shared.setUserData(userData)
        
        let vc = HomeConfiguration.articles(categories: selectedCategories, selectedCounty: selectedCountry, statusMode: .firstTime).viewController
        push(vc)
    }
    
    func updateView() {
        transperantNavBar()
        title = "News APP"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CountryCollectionViewCell.self)
        
        categoriesTableViewStack.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: CategoryTableViewCell.self)
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = 85
    }
}


//MARK: - CollectionView Data Source,Delegate And FlowLayout
extension CountriesAndCategoriesSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CountryCollectionViewCell.self, for: indexPath)
        presenter.configCollectionView(cell: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}


//MARK: - TableView DataSource And Delegate
extension CountriesAndCategoriesSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCategoriesItems
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CategoryTableViewCell.self, for: indexPath)
        presenter.configTableView(cell: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.didSelectTableViewCell(at: indexPath.row)
   }
}

//MARK: - Implement View Protocol
extension CountriesAndCategoriesSelectionViewController: CountriesAndCategoriesSelectionViewProtocol {
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    func reloadTableView() {
        tableView.isHidden = false
        categoriesTableViewStack.isHidden = false
        self.tableView.reloadData()
    }
    
    func reloadTableRow(at index: Int) {
        tableView.reloadRows(at: [.init(row: index, section: 0)], with: .automatic)
    }
}
