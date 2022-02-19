//
//  LoaderViewProtocol.swift
//
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import UIKit
import NVActivityIndicatorView

protocol LoaderViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func enableUserAction()
    func disableUserAction()
}

extension LoaderViewProtocol where Self: UIViewController {

    func startLoading(){
        let activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .MainYellow, padding: .zero)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            if let indicator = self.view.subviews.first(where: {$0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }

    }
    
    func enableUserAction(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
        }
    }
    func disableUserAction(){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
        }
    }
}


protocol TableOrCollectionViewProtocol: AnyObject {
   
    // func config<T>(cell: T, for index: Int)
}
