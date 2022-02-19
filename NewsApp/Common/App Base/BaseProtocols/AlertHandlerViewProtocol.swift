//
//  AlertHandlerViewProtocol.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import UIKit

protocol AlertHandlerViewProtocol {
    func showAlert(with message: String, title: AllertThemes)
}

extension AlertHandlerViewProtocol where Self: UIViewController {
    func showAlert(with message: String, title: AllertThemes) {
        AlertViewHandler().showAlert(message: message, title: title)
    }
}

