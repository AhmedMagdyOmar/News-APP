//
//  MainViewBorder.swift
//  Naqliah Client
//
//  Created by Ahmed on 20/12/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func makeViewBorder(to view: UIView, color: UIColor) {
        view.viewBorderWidth = 0.7
        view.viewBorderColor = color
    }
    
    func makeViewBorder(to view: UIView, color: UIColor, imageView: UIImageView, imageName: String) {
        view.viewBorderWidth = 0.7
        view.viewBorderColor = color
        imageView.image = UIImage(named: imageName)
    }
}
