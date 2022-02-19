//
//  HomeRepo.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import Foundation

protocol HomeRepoProtocol: AnyObject {
    func getCountries(handler: @escaping(AppResponse<CountriesAndCategoriesDataModel>) -> Void)
    func getCategoriesFor(country: String, handler: @escaping(AppResponse<CountriesAndCategoriesDataModel>) -> Void)

}


class HomeRepo {
    
    private let network: NetworkProtocol
    init(network: NetworkProtocol) {
        self.network = network
    }
}


extension HomeRepo: HomeRepoProtocol {
    func getCountries(handler: @escaping(AppResponse<CountriesAndCategoriesDataModel>) -> Void) {
        network.request(HomeRouter.getCountriesAndCategories, decodeTo: CountriesAndCategoriesDataModel.self, completionHandler: handler)
    }
    
    func getCategoriesFor(country: String, handler: @escaping(AppResponse<CountriesAndCategoriesDataModel>) -> Void) {
        network.request(HomeRouter.getCategories(country: country), decodeTo: CountriesAndCategoriesDataModel.self, completionHandler: handler)
    }
    

}
