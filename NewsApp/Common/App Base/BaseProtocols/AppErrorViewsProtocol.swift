//
//  AppErrorViewsProtocol.swift
//  
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit

protocol AppErrorViewsProtocol {
    func showNoInternetView(show: Bool, delegate: NoInternetDelegate?)
    func showTimeRequestOutView(show: Bool, delegate: NoInternetDelegate?)
    func showServerErrorView(show: Bool, delegate: NoInternetDelegate?)
}

extension AppErrorViewsProtocol where Self: UIViewController {
    
    func showNoInternetView(show: Bool, delegate: NoInternetDelegate?) {
        self.showNoInterNetView(show: show, delegate: delegate, errorType: .noInternet)
    }
    
    func showTimeRequestOutView(show: Bool, delegate: NoInternetDelegate?, mainView:UIView?) {
        self.showNoInterNetView(show: show, delegate: delegate, errorType: .timeRequestOut)
    }
    
    func showServerErrorView(show: Bool, delegate: NoInternetDelegate?, mainView:UIView?){
        self.showNoInterNetView(show: show, delegate: delegate, errorType: .serverError)
    }
    
}

