
//  NoDataViewController.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//


import UIKit

//protocol NoDataViewControllerDelegate:class {
//    func goToHomeBtnSelected()
//}
class NoDataViewController: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageLogo: UIImageView!

//    private weak var delegate:NoDataViewControllerDelegate?
    func setData(image: UIImage, description: String?,title:String) {
//        imageLogo.image = image
        lblTitle.text = title
//        fadeIn()
    }
    func fadeIn(withDuration duration: TimeInterval = 1.0) {
        imageLogo.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.imageLogo.alpha = 1.0
        })
    }
   
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commenInitialization()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commenInitialization()
    }

    func commenInitialization() {
        Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       
    
    }
}
