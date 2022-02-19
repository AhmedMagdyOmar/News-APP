//
//  ArticleHomePresenter.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import Foundation


struct CategoriesWithOwnArticles {
    var category: String
    var articles: [ArticlesModel]
}


enum ModeType {
    case defaultMode
    case searchMode
}

protocol ArticleHomePresenterProtocol {
    
    // Showing Selected Categories
    var getNumberOfSections: Int {get}
    func getNumbersOfRowsFor(section: Int) -> [ArticlesModel]?
    func  getCategoryNameFor(_ section: Int) -> String?
    func config(cell: ArticleTableViewCellProtocol, for index: Int, in section: Int)
    func didSelect(at index: Int, for section: Int) -> String?

    var getNumberOfSearchedArticles: Int {get}
    func didChange(text: String?)
    func viewDidLoad()
    var getModeType: ModeType {get}
  
}
class ArticleHomePresenter {
    
    //MARK: - Vars
    
    var categoriesWithOwnArticles: [CategoriesWithOwnArticles] = []
    private let dispatchGroup: DispatchGroup = DispatchGroup()
    var articles: [ArticlesModel] = []
    var searchedArticles: [ArticlesModel] = []
    var modeType:  ModeType = .defaultMode
    
    private weak var view: ArticlesHomeViewProtocol!
    var repo: ArticlesRepoProtocol
    var categories: [String]
    var selectedCountry: String
    init(repo:ArticlesRepoProtocol, view: ArticlesHomeViewProtocol, categories: [String], selectedCountry: String) {
        self.repo = repo
        self.view = view
        self.categories = categories
        self.selectedCountry = selectedCountry
    }
}

// MARK: - Implement Presenter Protocol
extension ArticleHomePresenter: ArticleHomePresenterProtocol {
  
    
    var getNumberOfSections: Int {
        categoriesWithOwnArticles.count
    }
    
    func getNumbersOfRowsFor(section: Int) -> [ArticlesModel]? {
        let articles = categoriesWithOwnArticles[section].articles
        return articles
    }
    
    func getCategoryNameFor(_ section: Int) -> String? {
        let category = categoriesWithOwnArticles[section].category
        return category
    }
    
    func config(cell: ArticleTableViewCellProtocol, for index: Int, in section: Int) {
        switch modeType {
            case .defaultMode:
                articles = categoriesWithOwnArticles[section].articles
                cell.display(model: ArticleCellViewModel(model: articles[index]))
            case .searchMode:
                cell.display(model: ArticleCellViewModel(model: searchedArticles[index]))
        }
    }
    
    func didSelect(at index: Int, for section: Int) -> String? {
        switch modeType {
        case .defaultMode:
            let articles = categoriesWithOwnArticles[section].articles
            let url = articles[index].url
            return url
        case .searchMode:
            let url = searchedArticles[index].url
            return url
        }
    }
    
    var getNumberOfSearchedArticles: Int {
        return searchedArticles.count
    }
    
    
    func viewDidLoad() {
        self.view.startLoading()
        let _ = self.categories.map { category in
            self.getArticles(category: category)
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view.stopLoading()
            self.view.reloadTableView()
        }
    }
   
    
    func didChange(text: String?) {
        if text.isNilOrEmpty {
            modeType = .defaultMode
            view.reloadTableView()
        } else {
            modeType = .searchMode
            searchFor(text!)
            view.reloadTableView()
        }
    }

    var getModeType: ModeType {
        return modeType
    }

}


//MARK: -  Networking
extension ArticleHomePresenter: HandleResponseError {
    func getArticles(category: String) {
        dispatchGroup.enter()
        repo.getArticlesFor(category, in: selectedCountry) { [weak self] response in
            guard let self = self else {return}
            switch response {
            case .success(let value):
                guard let articles = value.articles else {return}
                let newArticles = articles.sorted(by: { $0.publishedAt?.compare($1.publishedAt ?? Date()) == .orderedDescending})
                let item = CategoriesWithOwnArticles(category: category, articles: newArticles)
                self.categoriesWithOwnArticles.append(item)
            case .error(let err):
                self.handleErrorResponse(error: err, view: self.view)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func searchFor(_ keyword: String) {
        self.view.startLoading()
        repo.searchFor(keyword) { [weak self] response in
            guard let self = self else {return}
            self.view.stopLoading()
            switch response {
            case .success(let value):
                self.searchedArticles = value.articles ?? []
            case .error(let err):
                self.handleErrorResponse(error: err, view: self.view)
            }
        }
    }
}


