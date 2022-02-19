//
//  UiviewController+SideMenu.swift
//  Seeda
//
//  Created by Ahmed on 11/08/2021.
//

import Foundation
import UIKit


extension UIViewController {
    
    @objc  func shareWhatsApp(number: String){
        
        let urlString = "whatsapp://send?text=\(number)"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        guard let url  = URL(string: urlStringEncoded!) else { return   } 

        openURL(url: url)
        
    }



func openURL(url:URL){
    
    if UIApplication.shared.canOpenURL(url as URL)
    {
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }else{
                
    }
}
    
    func openUrl(url: String?) {
        let value = url ?? ""
        guard let _url  = URL(string: value) else{return}
        openURL(url: _url)
    }

    
    func callingMobile(mobile: String?)  {
        guard let phone = mobile else{return}
        guard let url = URL(string: "TEL://\(phone)")else{return}
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
