//
//  ArticlesRepo.swift
//  NewsApp
//
//  Created by Ahmed on 18/02/2022.
//

import Foundation

protocol ArticlesRepoProtocol {
    
    func getArticlesFor(_ category: String, in country: String, handler: @escaping(AppResponse<ArticlesDataModel>) -> Void)
    func searchFor(_ keyword: String, handler:@escaping(AppResponse<ArticlesDataModel>) -> Void)
}


class ArticlesRepo {
    private let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
}


extension ArticlesRepo: ArticlesRepoProtocol {
    func getArticlesFor(_ category: String, in country:String , handler: @escaping(AppResponse<ArticlesDataModel>) -> Void) {
        network.request(ArticlesRouter.getArticles(country: country, category: category), decodeTo: ArticlesDataModel.self, completionHandler: handler)
    }
    
    func searchFor(_ keyword: String, handler:@escaping(AppResponse<ArticlesDataModel>) -> Void) {
        network.request(ArticlesRouter.searchFor(keyword), decodeTo: ArticlesDataModel.self, completionHandler: handler)
    }
}
