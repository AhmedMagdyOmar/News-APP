//
//  MainButton.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        makeItDisable()
    }

    func makeItDisable() {
        isEnabled = false
        layer.borderWidth = 0
        isUserInteractionEnabled = false
        tintColor = .mainWhite
        setTitleColor(.mainWhite, for: .normal)
        backgroundColor = .lightGray
//        removeGradient()
    }

    func makeItEnable(gradientType: GradientType = .fromTopToBottom ) {
        isEnabled = true
        layer.borderWidth = 0
        isUserInteractionEnabled = true
        tintColor = .mainWhite
        setTitleColor(.mainWhite, for: .normal)
        backgroundColor = .mainColor
        layoutIfNeeded()
    }
}
