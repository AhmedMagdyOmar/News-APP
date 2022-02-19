//
//  UserData.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import UIKit

enum UserType {
    case investor
    case influencer
    case guest
}

class CacheService {

    private let userDataKey = "_UserData_"
    static let shared = CacheService()

    func getUserData() -> UserData? {
        let defaults = UserDefaults.standard
        guard let savedPerson = defaults.object(forKey: userDataKey) as? Data,
              let loadedData = try? JSONDecoder().decode(UserData.self, from: savedPerson)
        else { return nil }
        return loadedData
    }
    
     func setUserData(_ newValue: UserData?) {
        // guard let newValue = newValue else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newValue) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userDataKey)
        } else {
            fatalError("Unable To Save User Data")
        }
    }
    func setTapCustomerID(_ newValue: String?) {
        let defaults = UserDefaults.standard
        defaults.set(newValue, forKey: "TapCustomerID")
        defaults.synchronize()
   }
    
    func setSelectedCountry(_ newValue: String?) {
        let defaults = UserDefaults.standard
        defaults.set(newValue, forKey: "country")
        defaults.synchronize()
   }
    
    func getSelectedCountry() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "country") as? String
   }
    
    
    func getTapCustomerID() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "TapCustomerID") as? String
   }
    
    func isVideoFirstTime(isFirstTime: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isFirstTime, forKey: "IntroductionVideo")
        defaults.synchronize()
   }
    func getIsVideoFirstTime() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "IntroductionVideo") as? Bool
   }
    func setIsIntro(isIntro: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isIntro, forKey: "isIntro")
        defaults.synchronize()
   }
    func getIsIntro() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isIntro") as? Bool
   }
    var userType: UserType {
//        guard let userType = getUserData()?.userType else{return .guest}
////        guard let isComplete = getUserData()?.isCompletedData else{return .guest}
//        if userType == "investor" {
//            return .investor
//        }
        return .influencer
    }
}

extension CacheService {
    static func restartAppAndRemoveCachingData() {
        CacheService().setUserData(nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let window = UIApplication.shared.keyWindow else { fatalError() }
//            window.rootViewController = AuthConfiguration.login.viewController.hideNavigation
            UIView.transition(with: window, duration: 1.0, options: .curveEaseIn, animations: nil, completion: nil)
        }
    }
    
    @objc static func goToHomeScreenAfterLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let window = UIApplication.shared.keyWindow else { fatalError() }
            //window.rootViewController = TabBarManager()
            UIView.transition(with: window, duration: 1.0, options: .curveEaseIn, animations: nil, completion: nil)
        }
    }
}



//        window?.rootViewController = TabBarManager()
