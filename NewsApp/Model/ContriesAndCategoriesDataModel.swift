//
//  ContriesAndCategoriesDataModel.swift
//  NewsApp
//
//  Created by Ahmed on 16/02/2022.
//

import Foundation

// MARK: - UpdateCarDataModel
struct CountriesAndCategoriesDataModel: BaseCodable {
    var status: String
    var message: String?
    let sources: [CountriesAndCategoriesModel]?
}

// MARK: - Source
struct CountriesAndCategoriesModel: Codable {
    let id, name, sourceDescription: String?
    let url: String?
    let category: String?
    let language, country: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

