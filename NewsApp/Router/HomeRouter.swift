//
//  ArticlesHomeRouter.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import Foundation
import Alamofire

enum HomeRouter: URLRequestConvertible {
    
    case getCountriesAndCategories
    case getCategories(country: String)
   
    var encoding: ParameterEncoding {
        switch self {
        case .getCountriesAndCategories, .getCategories:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getCountriesAndCategories:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCountriesAndCategories:
            return nil
            
        case .getCategories(let country):
            return ["country": country]
            
        }
    }
        
    
    var path: String {
        switch self {
        case .getCountriesAndCategories, .getCategories:
            return "/v2/top-headlines/sources?"
        }
    }
}
