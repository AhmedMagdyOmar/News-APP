//
//  Configuration.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//


import Foundation
enum Configuration {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
            case let value as T:
                return value
            case let string as String:
                guard let value = T(string) else { fallthrough }
                return value
            default:
                throw Error.invalidValue
        }
    }
}

enum ConstantsEnum {
    static var baseURL: String {
        return Constants.baseUrlKey//Configuration.value(for: Constants.baseUrlKey)
    }
    
    static var APIKey: String {
        return Constants.APIKey//Configuration.value(for: Constants.baseUrlKey)
    }
    
    static var echoPort: String {
        return "6082"
    }
    static let socketPort = "3010"

}


struct Constants {
    static let baseUrlKey = "https://newsapi.org"
    static var responseValid = "ok"
    static let APIKey = "apiKey=57c64a59ec4649afbbada24f5244a4f3"
    static let apiGoogleMap = "kk"
}

