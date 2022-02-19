//
//  HandleResponseError.swift
//  
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import Foundation
import Alamofire

protocol HandleResponseError {
    func handleErrorResponse(error: AppError, view: AlertHandlerViewProtocol)
}

extension HandleResponseError {
    
    func handleErrorResponse( error: AppError, view: AlertHandlerViewProtocol) {
        switch error {
        case .cannotDecode:
            view.showAlert(with: error.errorDescription ?? "", title: .error)
        case .noInternet:
            view.showAlert(with: error.errorDescription ?? "", title: .error)
        case .error(let error):
            view.showAlert(with: error, title: .error)
        case .tokenExpire:
            view.showAlert(with: error.errorDescription ?? "", title: .error)
        case .internalServerError:
            view.showAlert(with: error.errorDescription ?? "", title: .error)
        case .timeOut:
            view.showAlert(with: error.errorDescription ?? "", title: .error)
        }
    }
}
