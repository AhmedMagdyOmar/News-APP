//
//  UIFont+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func cairoExtraBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProMedium", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoLight(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProLight", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansPro-Bold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoSemiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    
    static func cairoRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansPro-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoBlack(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
   
   
    
    var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }
}
