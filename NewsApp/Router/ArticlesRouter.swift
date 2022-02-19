//
//  ArticlesRouter.swift
//  NewsApp
//
//  Created by Ahmed on 18/02/2022.
//

import Foundation

import Foundation
import Alamofire

enum ArticlesRouter: URLRequestConvertible {
    case getArticles(country: String, category: String)
    case searchFor(_ keyword: String)
    
     var encoding: ParameterEncoding {
         switch self {
         case  .getArticles ,.searchFor:
             return URLEncoding.default
         default:
             return JSONEncoding.default
         }
     }
     
     
     var method: HTTPMethod {
         switch self {
         case .getArticles, .searchFor:
             return .get
         }
     }
     
     var parameters: [String : Any]? {
         switch self {
         case .getArticles(let country, let category):
             return ["category": category ,"country":country]
     
         case .searchFor(let keyword):
             return ["q":keyword]
         }
     }
         
     
     var path: String {
         switch self {
  
         case .getArticles:
             return "/v2/top-headlines?"
            
         case .searchFor:
             return "/v2/everything?"
         }
     }
 }
