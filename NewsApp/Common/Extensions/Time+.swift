//
//  Time+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 19/12/2021.
//

import Foundation
extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
