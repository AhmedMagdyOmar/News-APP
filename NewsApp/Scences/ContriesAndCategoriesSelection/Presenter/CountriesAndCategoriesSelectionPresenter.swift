//
//  CountriesAndCategoriesSelectionPresenter.swift
//  NewsApp
//
//  Created by Ahmed on 16/02/2022.
//

import Foundation

protocol CountriesAndCategoriesSelectionPresenterProtocol {
    
    // CountriesCollectionView
    var  getSelectedCountry: String {get}
    var getNumberOfItems:Int {get}
    func didSelect(at index: Int)
    func configCollectionView(cell: CountryCollectionViewCellProtocol, for index: Int)
      
    // CategoriesTableView
    var getCategoriesItems : Int {get}
    var getSelectedCategories: [String] {get}
    func configTableView(cell:CategoryTableViewCellProtocol, for index: Int)
    func didSelectTableViewCell(at index: Int)
        
    func viewDidLoad()

}


class CountriesAndCategoriesSelectionPresenter {
    
    var allCountries: [String] = []
    var allCategories: [CategoriesViewModel] = []
    var selectedCategoriesIndexes: [Int] = []
    var selectedCountry: String = ""
    
    private var selectedCountryIndex: Int?
    private weak var view: CountriesAndCategoriesSelectionViewProtocol!
    var repo: HomeRepoProtocol
    
    init(view: CountriesAndCategoriesSelectionViewProtocol, repo: HomeRepoProtocol) {
        self.view = view
        self.repo = repo
    }
}

extension CountriesAndCategoriesSelectionPresenter: CountriesAndCategoriesSelectionPresenterProtocol {
   
    // CountriesCollectionView
    var getNumberOfItems: Int {
        return allCountries.count
    }
    
    var getSelectedCountry: String {
        return selectedCountry
    }
    
    func didSelect(at index: Int) {
         self.selectedCountryIndex = index
         let countryName = allCountries[index]
         view.reloadCollectionView()
         self.selectedCountry = countryName
         selectedCategoriesIndexes.removeAll()
         getCategories(for: countryName)
    }
    
    func configCollectionView(cell: CountryCollectionViewCellProtocol, for index: Int) {
        cell.display(item: allCountries[index], isSelected: index == selectedCountryIndex)
    }
    
    
    // CategoriesTableView
    var getCategoriesItems: Int {
        return allCategories.count
    }
    
    func configTableView(cell:CategoryTableViewCellProtocol, for index: Int) {
        cell.display(allCategories[index])
    }
    
    
    private func fillCategoryVM(data: [String]) -> [CategoriesViewModel] {
        let arr = data.map({
            CategoriesViewModel.init(category: $0)
        })
        return arr
    }
    
    
    func didSelectTableViewCell(at index: Int) {
        allCategories[index].isSelected = !allCategories[index].isSelected
        if allCategories[index].isSelected {
             selectedCategoriesIndexes.append(index)
        } else {
            guard let removedItem = selectedCategoriesIndexes.firstIndex(of: index) else {return}
            selectedCategoriesIndexes.remove(at: removedItem)
        }
            view.reloadTableView()
    }
        
    var getSelectedCategories: [String] {
        let arr =  selectedCategoriesIndexes.map { element in
            allCategories[element].category
        }
        return arr
    }
    
    
    func viewDidLoad() {
        getCountries()
    }
}


//MARK: - Networking
extension CountriesAndCategoriesSelectionPresenter : HandleResponseError {
    
    func getCountries() {
        self.view.startLoading()
        repo.getCountries { [weak self] response in
            guard let self = self else {return}
            self.view.stopLoading()
            switch response {
            case .success(let value):
                guard let data = value.sources else {return}
                let allCountries = data.compactMap { element in element.country }
                self.allCountries = Array(Set(allCountries))
                self.view.reloadCollectionView()
            case .error(let err):
                self.handleErrorResponse(error: err, view: self.view)
            }
        }
    }
    
    
    func getCategories(for country: String) {
        self.view.startLoading()
        repo.getCategoriesFor(country: country) { [weak self] response in
            guard let self = self else {return}
            self.view.stopLoading()
            switch response {
            case .success(let value):
                guard let data = value.sources else {return}
                let allCategories = data.compactMap { element in element.category}
                let unRepeatedCategories = Array(Set(allCategories))
                self.allCategories = self.fillCategoryVM(data: unRepeatedCategories)
                self.view.reloadTableView()
            case .error(let err):
                self.handleErrorResponse(error: err, view: self.view)
            }
        }
    }
}



