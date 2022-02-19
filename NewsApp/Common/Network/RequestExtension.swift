//
//  RequestExtension.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//


import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("====================******************===================")
        debugPrint(self)
        debugPrint("====================******************===================")
        #endif
        return self
    }
}
