//
//  UIButton+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    var title: String {
        get {
            return title(for: .normal) ?? ""
        } set {
            setTitle(newValue, for: .normal)
        }
    }
    
    func underlineText() {
        guard let title = title(for: .normal) else { return }

        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(
          .underlineStyle,
          value: NSUnderlineStyle.single.rawValue,
          range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(titleString, for: .normal)
      }

}

extension UIButton {
    private struct AssociatedObjectKeyss {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    private typealias Action = (() -> Void)?
    private typealias ActionWithButton = ((_ button: UIButton) -> Void)?

    // Set our computed property type to a closure
    private var tapAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // Set our computed property type to a closure
    private var tapActionWithButton: ActionWithButton? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer) as? ActionWithButton
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    @discardableResult
    func addTarget(action: (() -> Void)?) -> Self {
        tapAction = action
        addTarget(self, action: #selector(handleTapTarget), for: .touchUpInside)
        return self
    }
    
    @discardableResult
    func addTarget(action: ((_ button: UIButton) -> Void)?) -> Self {
        tapActionWithButton = action
        addTarget(self, action: #selector(handleTapTarget), for: .touchUpInside)
        return self
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc private func handleTapTarget(sender: UIButton) {
        if let tapAction = tapAction {
            tapAction?()
        } else if let tapActionWithButton = tapActionWithButton {
            tapActionWithButton?(self)
        }
    }
}

