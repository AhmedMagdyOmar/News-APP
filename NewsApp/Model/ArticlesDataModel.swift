//
//  ArticlesDataModel.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import Foundation


 //MARK: - UpdateCarDataModel
struct ArticlesDataModel: BaseCodable {
    var status: String
    var message: String?
    let totalResults: Int?
    let articles: [ArticlesModel]?
}

// MARK: - Article
struct ArticlesModel: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

