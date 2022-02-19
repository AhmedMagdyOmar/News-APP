//
//  Object.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return "\(self)"
    }
    
    var jsonToString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func cast<T: Any>(to type: T.Type) -> T? {
        return self as? T
    }
    
    func forceCast<T: Any>(to type: T.Type) -> T {
        return self as! T
    }
}
