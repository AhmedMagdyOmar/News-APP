//
//  UIimageView+.swift
//  Naqliah Client
//
//  Created by Ahmed on 09/11/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(with url: String?, cop: ((_ image: UIImage?) -> Void)? = nil) {
        let placeHolder = #imageLiteral(resourceName: "error")
        image = placeHolder
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .MainYellow
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.image = placeHolder
                cop?(nil)
            } else {
                self?.image = image
                cop?(image)
            }
        }
    }
}

extension UIButton {
    func load(with url: String?, cop: ((_ image: UIImage?) -> Void)? = nil) {
        let placeHolder = #imageLiteral(resourceName: "placeHolder")
        setBackgroundImage(placeHolder, for: .normal)
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .MainYellow
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, for: .normal, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.setBackgroundImage(placeHolder, for: .normal)
                cop?(nil)
            } else {
                self?.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
                cop?(image)
            }
        }
    }
}

class FlipImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        let language = L102Language.getCurrentLanguage()
        print(language)
        if language == "ar" {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }else{
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
}
extension UIImageView {
  @IBInspectable var isFlipInRTL: Bool {
    set {
      if newValue {
        image = self.image?.imageFlippedForRightToLeftLayoutDirection()
      }
    }
     
    get {
      self.image?.flipsForRightToLeftLayoutDirection ?? false
    }
  }
}

extension UIButton {
  @IBInspectable var isFlipInRTL: Bool {
    set {
      if newValue {
        setImage(self.imageView?.image?.imageFlippedForRightToLeftLayoutDirection(), for: .normal)
      }
    }
     
    get {
        self.imageView?.image?.flipsForRightToLeftLayoutDirection ?? false
    }
  }
}
