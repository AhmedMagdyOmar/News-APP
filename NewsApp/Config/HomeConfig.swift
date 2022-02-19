//
//  HomeConfig.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import UIKit

protocol ConfigurationProtocol {
    var viewController: UIViewController {get}
}

enum HomeConfiguration: ConfigurationProtocol {

    case countriesAndCategories
    case articles(categories: [String], selectedCounty: String, statusMode: StatusMode)
    
    var viewController: UIViewController {
        switch self {
        
        case .countriesAndCategories:
            let network = Network()
            let mainRepo = HomeRepo(network: network)
            let view = CountriesAndCategoriesSelectionViewController()
            let presenter = CountriesAndCategoriesSelectionPresenter(view: view, repo: mainRepo)
            view.presenter = presenter
            return view
            
        case let .articles( categories, selectedCounty, statusMode):
            let network = Network()
            let mainRepo = ArticlesRepo(network: network)
            let view = ArticlesHomeViewController(statusMode: statusMode)
            let presenter = ArticleHomePresenter(repo: mainRepo, view: view, categories: categories, selectedCountry: selectedCounty)
            view.presenter = presenter
            return view
            
        }

            
    
        
    }
}
