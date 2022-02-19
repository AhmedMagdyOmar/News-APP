//
//  UIViewController+Extension.swift
//  anfy


import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    
    func addPopGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    func setActivityIndicator(play: Bool, activityIndicator: UIActivityIndicatorView) {
        if play {
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
    }

  

    func forceToArabic(vc: UIViewController) {
        L102Language.setAppleLanguageTo(lang: langugae.arabic.lang)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UserDefaults.standard.set("yes", forKey: "lang")
        changeWindow(vc: vc)
    }
    
    func changeWindow(vc: UIViewController) {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootViewController.rootViewController = vc
        let mainWindow = (UIApplication.shared.delegate?.window!)!
        mainWindow.backgroundColor = .black
        UIView.transition(with: mainWindow, duration: 0.55001, options: .transitionCrossDissolve, animations: { () -> Void in
        }) { (_) -> Void in
        }
    }
    
    func forceToEnglish(vc: UIViewController) {
        L102Language.setAppleLanguageTo(lang: langugae.english.lang)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UserDefaults.standard.set("yes", forKey: "lang")
        changeWindow(vc: vc)
    }

    func changeLanguage(vc: UIViewController) {
        if L102Language.currentAppleLanguage() == langugae.english.lang {
            L102Language.setAppleLanguageTo(lang: langugae.arabic.lang)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLanguageTo(lang: langugae.english.lang)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        changeWindow(vc: vc)
    }
    @objc  func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController{
    func alertPermission() {
        let alertController = UIAlertController(title: "Location Permission Required".localized, message: "Please enable location permissions in settings.".localized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings".localized, style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UITableView {
    @IBInspectable
    var hideSeparatorForEmptyCells: Bool {
        set {
            tableFooterView = newValue ? UIView() : nil
        }
        get {
            return tableFooterView == nil
        }
    }
}



extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
