//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        //configNavigation()
        configWindow()
        L102Localizer.DoTheMagic()
        return true
    }
}

extension AppDelegate {
    private func configWindow() {
        window = UIWindow()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        reset()
    }
    
    func reset() {
        let userData = CacheService.shared.getUserData()
        if userData?.country == nil || userData?.categories == nil {
            window?.rootViewController = HomeConfiguration.countriesAndCategories.viewController.toNavigation
        }else{
            guard let categories = userData?.categories else {return}
            guard let country = userData?.country else {return}
            window?.rootViewController = HomeConfiguration.articles(categories: categories, selectedCounty: country, statusMode: .secondTime).viewController.toNavigation

        }
    }
    
}
