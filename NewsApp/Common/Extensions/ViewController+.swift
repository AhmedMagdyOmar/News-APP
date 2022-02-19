//
//  UIViewController.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func customPresent(_ vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc ,animated: true, completion: nil)
    }
    
    func presentModelyVC(_ vc: UIViewController) {
        vc.definesPresentationContext = true
        if #available(iOS 13, *) {
            // vc.modalPresentationStyle = .fullScreen
        } else {
            vc.modalPresentationStyle = .custom
        }
        present(vc, animated: true, completion: nil)
    }
    
    func push(_ vc: UIViewController) {
//        vc.hidesBottomBarWhenPushed = true
    setBackButtonTitle(txt: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func push(after: Double,_ vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func popMe() {
        navigationController?.popViewController(animated: true)
    }
    
    func popMeWithDuration(after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func popToRoot(after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func clearNavigationBackButtonTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func navTitle(title: String? = nil) {
        if let title = title, title != "" {
            let titleLabel = UILabel()
            
            titleLabel.font = .cairoRegular(of: 20)
            titleLabel.withHeight(25)
//
            navigationItem.titleView = titleLabel
////            titleLabel.topAnchorSuperView(constant: 50)
////            titleLabel.centerXInSuperview()
        }
    }
    
    func configNavBar(title: String? = nil, isLarge: Bool, backgroundColor: UIColor = .white) {
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = isLarge
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.backgroundColor = backgroundColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    func whiteNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.mainColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.mainColor]
        appearance.setBackIndicatorImage(#imageLiteral(resourceName: "back"), transitionMaskImage: #imageLiteral(resourceName: "back"))
        appearance.backButtonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance.backgroundImage = UIImage()
        navigationController?.navigationBar.standardAppearance.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "URWDINArabic-Bold", size: 15)!]

    }

    
    func showAlertController(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.view.tintColor = .MainYellow
        alert.title = title
        alert.message = message
        
        alert.setValue(NSAttributedString(string: title ?? "", attributes: [.foregroundColor : UIColor.MainYellow]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message ?? "", attributes: [.foregroundColor: UIColor.MainYellow, .font: UIFont.boldSystemFont(ofSize: 14)]), forKey: "attributedMessage")
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok".localize, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    
    func setTitle(_ title: String) {
        navigationItem.title = title
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.cairoRegular(of: 16), .foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func transperantNavBar(backColor: UIColor = .white) {        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = backColor
    }
    
    func setStatusBarColor(to color: UIColor = .white) {
        var statusBar: UIView
        
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            let frame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame
            statusBar = UIView(frame: frame ?? .zero)
            keyWindow?.addSubview(statusBar)
        } else {
            statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView ?? UIView()
        }
        
        // statusBar.backgroundColor = color
    }
    
    func customeNavigationContoller() {
        // navigationController?.navigationBar.prefersLargeTitles = true

        transperantNavBar(backColor: .white)
     
//        navigationController?.navigationBar.setGradientBackground(to: self.navigationController!)
//
//        navigationController?.navigationBar.cornerRadiusBottom()
//        tabBarController?.tabBar.applyGradient()
//        tabBarController?.tabBar.cornerRadiusTop()
        
    }
    
    func navbarWithdismiss() {
        let exitButton = UIBarButtonItem(title: "Back".localize, style: .plain, target: self, action: #selector(dismissMePlease))
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc
    func dismissMePlease() {
        dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    func removeNotificationsObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    var toNavigation: UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.tintColor = .white
         var textAttributes = nav.navigationBar.titleTextAttributes
        textAttributes?[NSAttributedString.Key.foregroundColor] = UIColor.mainColor
            nav.navigationBar.titleTextAttributes = textAttributes
        return nav
    }
    var hideNavigation: UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        nav.setNavigationBarHidden(true, animated: true)
        return nav
    }
}

extension UIViewController {
    func addChildViewController(childViewController: UIViewController, childViewControllerContainer: UIView, comp: (() -> ())? = nil) {
        
        removeChildViewControllers()
        
        addChild(childViewController)
        
        childViewControllerContainer.addSubview(childViewController.view)
        childViewController.view.frame = childViewControllerContainer.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
        comp?()
    }
    
    func addChildViewControllerWithConstraint(childViewController: UIViewController, childViewControllerContainer: UIView, comp: (() -> ())? = nil) {
        removeChildViewControllers()
        
        addChild(childViewController)
        
        childViewControllerContainer.addSubview(childViewController.view)
        let constriants = [
            childViewController.view.topAnchor.constraint(equalTo: childViewControllerContainer.topAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: childViewControllerContainer.bottomAnchor),
            childViewController.view.leadingAnchor.constraint(equalTo: childViewControllerContainer.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: childViewControllerContainer.trailingAnchor)]
        childViewControllerContainer.addConstraints(constriants)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewControllerContainer.layoutIfNeeded()
        childViewController.didMove(toParent: self)
        comp?()

    }

    func removeChildViewControllers() {
        if children.count > 0 {
            for i in  children.enumerated() {
                children[i.offset].willMove(toParent: nil)
                children[i.offset].view.removeFromSuperview()
                children[i.offset].removeFromParent()
            }
        }
    }
}


extension UIViewController{
    
    func navigatewithGoogleMap(url: String){
        if let url = URL(string: url) , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else{
            let aler = UIAlertController(title: "Warning".localize, message: "You not installed Google Map Please Install it First".localize, preferredStyle: .alert)
            self.presentModelyVC(aler)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                aler.dismissMePlease()
                self.openAppStore(id:"585027354")
            }
        }
    }
    
    func openAppStore(id:String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(id)"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
                    print("App Store Opened")
                }
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
    func navToGoogleMap(sourceLat: Double, sourceLng: Double, destinationLat: Double, destinationLng: Double){
        let url = "http://maps.google.com/maps?saddr=\(sourceLat),\(sourceLng)&daddr=\(destinationLat),\(destinationLng)"
        print(url)
        
        if let url = URL(string: url) , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else{
            let aler = UIAlertController(title: "Warning".localize, message: "You not installed Google Map Please Install it First".localize, preferredStyle: .alert)
            self.presentModelyVC(aler)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                aler.dismissMePlease()
                self.openAppStore(id:"585027354")
            }
        }
        
    }
}

extension UIImageView {
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
            var gradientImage:UIImage?
            UIGraphicsBeginImageContext(gradientLayer.frame.size)
            if let context = UIGraphicsGetCurrentContext() {
                gradientLayer.render(in: context)
                gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            }
            UIGraphicsEndImageContext()
            return gradientImage
        }
}

extension UINavigationBar {
   
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}


extension UIViewController{
    func alertPermisn() {
        let alertController = UIAlertController(title: "Location Permission Required".localize, message: "Please enable location permissions in settings.".localize, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings".localize, style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    func setupNavBackButton() {
        let image = #imageLiteral(resourceName: "back").imageFlippedForRightToLeftLayoutDirection()
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget { [weak self] in
            guard let self = self else {return}
            self.popMe()
        }
        navigationItem.leftBarButtonItem = .init(customView: button)
    }

    func setRightButton(title: String) {
        let rightBtn = UIButton()
        //rightBtn.setImage(image, for: .normal)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(.mainColor, for: .normal)
        rightBtn.addTarget { [weak self] in
            CacheService.shared.setUserData(nil)
            AppDelegate.shared.reset()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem?.tintColor = .mainColor
    }
    
}
