//
//  CATransition+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        return transition
    }
}
