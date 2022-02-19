//
//  AlertViewThem.swift
//  
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import Foundation


enum AllertThemes {
    case error
    case success
    case warning
    
    var localize: String {
        switch self {
            case .error:
                return "Error"
            case .success:
                return "Success"
            case .warning:
                return "Warning"
        }
    }
    
   
}
