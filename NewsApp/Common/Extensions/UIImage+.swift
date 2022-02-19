//
//  UIImage+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIImage {
    var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    var original: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}

extension UIImage{
    func toData()->Data?{
        let data = self.jpegData(compressionQuality: 0.5)
        return data
    }
}

extension UIImage {
    static let HomeSelectedTab = UIImage(named: "home_a")!
    static let MessagesSelectedTab = UIImage(named: "Chat_a")!
    static let MyOrderSelectedTab = UIImage(named: "orders_a")!
    static let ProfileSelectedTab = UIImage(named: "profile_a")!
    
    static let HomeUnSelectedTab = UIImage(named: "home_in")!
    static let MessagesUnSelectedTab = UIImage(named: "Chat_in")!
    static let MyOrderUnSelectedTab = UIImage(named: "orders_in")!
    static let ProfileUnSelectedTab = UIImage(named: "profile_in")!
    
    static let homeService1 = UIImage(named: "ride_flip")!
    static let homeService2 = UIImage(named: "delivery_flip")!
    static let homeService3 = UIImage(named: "room_flip")!
    static let homeService4 = UIImage(named: "bicycle_flip")!

    static let mapIcon = UIImage(named: "location_map")!
    
    
    static let check = UIImage(named: "check")!
    static let unCheck = UIImage(named: "checkEmpty")!

}
