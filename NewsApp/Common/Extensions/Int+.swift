//
//  Int+.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed . All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var string: String {
        return "\(self)"
    }
}

extension Double {
    var string: String {
        return "\(self)"
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

extension Dictionary where Value: RangeReplaceableCollection {
    @discardableResult public mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) -> Value? {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
        return value
    }
}
