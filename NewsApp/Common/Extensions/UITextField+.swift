//
//  UITextField+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        } set {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
  
    var textUnwarrped: String {
        return text ?? ""
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func addBorderColor(color: UIColor = .white, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 7) {
        viewBorderColor = color
        viewBorderWidth = borderWidth
        viewCornerRadius = cornerRadius
    }
}


class PlaceHolderTextView: RSKPlaceholderTextView {
    init(placeHolder: String, backgroundColor: UIColor) {
        super.init(frame: .zero, textContainer: nil)
        self.placeholder = placeHolder as String
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 19
        layer.borderWidth = 1
        layer.borderColor = UIColor.MainYellow.cgColor
        font = .cairoRegular(of: 13)
        textColor = .black
        textAlignment = .natural
        applySketchShadow()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.MainYellow.cgColor
        font = .cairoRegular(of: 13)
        textColor = .black
        textAlignment = .natural
        applySketchShadow()

    }
}

/// A light-weight UITextView subclass that adds support for placeholder.
open class RSKPlaceholderTextView: UITextView {
    
    // MARK: - Private Properties
    
    private var placeholderAttributes: [NSAttributedString.Key: Any] {
        
        var placeholderAttributes = self.typingAttributes
        
        if placeholderAttributes[.font] == nil {
            
            placeholderAttributes[.font] = self.typingAttributes[.font] ?? self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        
        if placeholderAttributes[.paragraphStyle] == nil {
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.textAlignment
            paragraphStyle.lineBreakMode = self.textContainer.lineBreakMode
            placeholderAttributes[.paragraphStyle] = paragraphStyle
        }
        
        placeholderAttributes[.foregroundColor] = self.placeholderColor
        
        return placeholderAttributes
    }
    
    private var placeholderInsets: UIEdgeInsets {
        
        let placeholderInsets = UIEdgeInsets(top: self.contentInset.top + self.textContainerInset.top,
                                             left: self.contentInset.left + self.textContainerInset.left + self.textContainer.lineFragmentPadding,
                                             bottom: self.contentInset.bottom + self.textContainerInset.bottom,
                                             right: self.contentInset.right + self.textContainerInset.right + self.textContainer.lineFragmentPadding)
        return placeholderInsets
    }
    
    private lazy var placeholderLayoutManager: NSLayoutManager = NSLayoutManager()
    
    private lazy var placeholderTextContainer: NSTextContainer = NSTextContainer()
    
    // MARK: - Open Properties
    
    /// The attributed string that is displayed when there is no other text in the placeholder text view. This value is `nil` by default.
    @NSCopying open var attributedPlaceholder: NSAttributedString? {
        
        didSet {
            
            guard self.isEmpty == true else {
                
                return
            }
            self.setNeedsDisplay()
        }
    }
    
    /// Determines whether or not the placeholder text view contains text.
    open var isEmpty: Bool { return self.text.isEmpty }
    
    /// The string that is displayed when there is no other text in the placeholder text view. This value is `nil` by default.
    open var placeholder: String? {
        
        get {
            
            return self.attributedPlaceholder?.string as String?
        }
        set {
            
            if let newValue = newValue as String? {
                
                self.attributedPlaceholder = NSAttributedString(string: newValue, attributes: self.placeholderAttributes)
            }
            else {
                
                self.attributedPlaceholder = nil
            }
        }
    }
    
    /// The color of the placeholder. This property applies to the entire placeholder string. The default placeholder color is `UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)`.
    open var placeholderColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) {
        
        didSet {
            
            if let placeholder = self.placeholder as String? {
                
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.placeholderAttributes)
            }
        }
    }
    
    // MARK: - Superclass Properties
    
    open override var attributedText: NSAttributedString! { didSet { self.setNeedsDisplay() } }
    
    open override var bounds: CGRect { didSet { self.setNeedsDisplay() } }
    
    open override var contentInset: UIEdgeInsets { didSet { self.setNeedsDisplay() } }
    
    open override var font: UIFont? {
        
        didSet {
            
            if let placeholder = self.placeholder as String? {
                
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.placeholderAttributes)
            }
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        
        didSet {
            
            if let placeholder = self.placeholder as String? {
                
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.placeholderAttributes)
            }
        }
    }
    
    open override var textContainerInset: UIEdgeInsets { didSet { self.setNeedsDisplay() } }
    
    open override var typingAttributes: [NSAttributedString.Key: Any] {
        
        didSet {
            
            if let placeholder = self.placeholder as String? {
                
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: self.placeholderAttributes)
            }
        }
    }
    
    // MARK: - Object Lifecycle
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInitializer()
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer)
        
        self.commonInitializer()
    }
    
    // MARK: - Superclass API
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        
        guard self.text.isEmpty == true, let attributedPlaceholder = self.attributedPlaceholder else {
            
            return super.caretRect(for: position)
        }
        
        if self.placeholderTextContainer.layoutManager == nil {
            
            self.placeholderLayoutManager.addTextContainer(self.placeholderTextContainer)
        }
        
        let placeholderTextStorage = NSTextStorage(attributedString: attributedPlaceholder)
        placeholderTextStorage.addLayoutManager(self.placeholderLayoutManager)
        
        self.placeholderTextContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding
        self.placeholderTextContainer.size = self.textContainer.size
        
        self.placeholderLayoutManager.ensureLayout(for: self.placeholderTextContainer)
        
        var caretRect = super.caretRect(for: position)
        
        let placeholderUsedRect = self.placeholderLayoutManager.usedRect(for: self.placeholderTextContainer)
        
        let userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection
        if #available(iOS 10.0, *) {
            
            userInterfaceLayoutDirection = self.effectiveUserInterfaceLayoutDirection
        }
        else {
            
            userInterfaceLayoutDirection = UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
        }
        
        switch userInterfaceLayoutDirection {
            
        case .rightToLeft:
            caretRect.origin.x = placeholderUsedRect.maxX - self.placeholderInsets.left
            
        case .leftToRight:
            fallthrough
            
        @unknown default:
            caretRect.origin.x = placeholderUsedRect.minX + self.placeholderInsets.left
        }
        
        return caretRect
    }
    
    open override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard self.isEmpty == true else {
            
            return
        }
        
        guard let attributedPlaceholder = self.attributedPlaceholder else {
            
            return
        }
        
        let placeholderRect = rect.inset(by: self.placeholderInsets)
        attributedPlaceholder.draw(in: placeholderRect)
    }
    
    // MARK: - Private API
    
    private func commonInitializer() {
        
        self.contentMode = .topLeft
        
        NotificationCenter.default.addObserver(self, selector: #selector(RSKPlaceholderTextView.handleTextViewTextDidChangeNotification(_:)), name: UITextView.textDidChangeNotification, object: self)
    }
    
    @objc internal func handleTextViewTextDidChangeNotification(_ notification: Notification) {
        
        guard let object = notification.object as? RSKPlaceholderTextView, object === self else {
            
            return
        }
        self.setNeedsDisplay()
    }
}
class TextFieldSpinner: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(UIResponderStandardEditActions.paste(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.cut(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.copy(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.select(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.selectAll(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.decreaseSize(_:)) {
        return false
    }
    
    if action == #selector(UIResponderStandardEditActions.increaseSize(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.toggleBoldface(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.perform(_:)) {
        return false
    }
    if action == #selector(UIResponderStandardEditActions.perform(_:)) {
        return false
    }
        return super.canPerformAction(action, withSender: sender)
   }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
   
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    

}
