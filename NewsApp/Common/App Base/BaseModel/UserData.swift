//
//  UserData.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: BaseCodable {
    let data: UserData?
    let status: String
    let message: String?
    let devMessage: Int?
}

// MARK: - DataClass
struct UserData: Codable {
    let country: String?
    let categories: [String]?
}
//
//        let isActive: Bool?
//        let fullname: String?
//        var allowNotification: Bool?
//        let rateAvg: Int?
//        let phonecode: String?
//        let image: String?
//        let phone: String?
//        let totalWallet: Double?
//        let phonecodeData: PhonecodeData?
//        let id: String?
//        let unreadNotifications: Int?
//        var token: String?
//        let isBan: Bool?
//        let userType: String?
//
//        enum CodingKeys: String, CodingKey {
//            case isActive = "is_active"
//            case fullname
//            case allowNotification = "allow_notification"
//            case rateAvg = "rate_avg"
//            case phonecode, image, phone
//            case totalWallet = "total_wallet"
//            case phonecodeData = "phonecode_data"
//            case id// = "user_id"
//            case unreadNotifications = "unread_notifications"
//            case token
//            case isBan = "is_ban"
//            case userType = "user_type"
//        }
    //}
//
//    // MARK: - PhonecodeData
//    struct PhonecodeData: Codable {
//        let phonecode, name, id: String?
//        let flag: String?
//    }
//
//
//// MARK: - Brand
//struct Brand: Codable {
//    let id: Int?
//    let name: String?
//    let image: String?
//}
//
//// MARK: - City
//struct City: Codable {
//    let id: Int?
//    let name: String?
//}
//
//// MARK: - CarPackage
//struct CarPackage: Codable {
//    let id, numberOfSeats, carKMPrice, minWallet: Int?
//    let isActive: Bool?
//    let name: String?
//    let image: String?
//    let desc: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case numberOfSeats = "number_of_seats"
//        case carKMPrice = "car_km_price"
//        case minWallet = "min_wallet"
//        case isActive = "is_active"
//        case name, image, desc
//    }
//}
//
//// MARK: - Country
//struct Country: Codable {
//    let id: Int?
//    let name, nationality, key: String?
//    let flag: String?
//}
//
//// MARK: - CarData
//struct CarData: Codable {
//    let id: Int?
//    let carFrontImage, carBackImage, carLicenceImage, carInsuranceImage: String?
//    let carFormImage: String?
//    let licenseSerialNumber, plateLetterLeft, plateLetterRight, plateLetterMiddle: String?
//    let plateNumbersOnly, manufactureYear, plateNumber: String?
//    let plateType: City?
//    let brand: Brand?
//    let carModel: City?
//    let carPackage: CarPackage?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case carFrontImage = "car_front_image"
//        case carBackImage = "car_back_image"
//        case carLicenceImage = "car_licence_image"
//        case carInsuranceImage = "car_insurance_image"
//        case carFormImage = "car_form_image"
//        case licenseSerialNumber = "license_serial_number"
//        case plateLetterLeft = "plate_letter_left"
//        case plateLetterRight = "plate_letter_right"
//        case plateLetterMiddle = "plate_letter_middle"
//        case plateNumbersOnly = "plate_numbers_only"
//        case manufactureYear = "manufacture_year"
//        case plateNumber = "plate_number"
//        case plateType = "plate_type"
//        case brand
//        case carModel = "car_model"
//        case carPackage = "car_package"
//    }
//}
