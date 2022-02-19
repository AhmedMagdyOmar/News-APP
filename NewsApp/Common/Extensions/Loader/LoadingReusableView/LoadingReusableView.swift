//
//  CollectionViewLoadingReusableView.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = .MainYellow
        activityIndicator.isHidden = true
        view.backgroundColor = .clear
    }
}
