//
//  AuthModel.swift
//  Naqliah Client
//
//  Created by Ahmed on 10/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation

// MARK: - AuthModel
struct AuthModel: BaseCodable {
    var status: String
    let data: AuthData?
    let isActive: Bool?
    let devMessage: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status, data
        case isActive = "is_active"
        case devMessage = "dev_message"
        case message
    }
}

// MARK: - AuthData
struct AuthData: Codable {
    let userID: Int?
    let userType, phonecode, phone: String?
    let carPackageID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userType = "user_type"
        case phonecode, phone
        case carPackageID = "car_package_id"
    }
}
