//
//  TableViewExtension.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyData(image:UIImage ,title:String ) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: image, description: description, title: title)
        backgroundView = vc
    }
   
    func removeBackGroundView() {
        backgroundView = nil
    }
}

extension UICollectionView {
    func setEmptyData(image:UIImage,description:String ,title:String) {
        let vc = NoDataViewController(frame: .zero)
        vc.setData(image: image, description: description, title: title)
        backgroundView = vc
    }
    
    func removeBackGroundView() {
        backgroundView = nil
    }
}
