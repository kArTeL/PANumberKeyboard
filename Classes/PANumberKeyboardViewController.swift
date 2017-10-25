//
//  KeyboardViewController.swift
//  DecimalKeyboard
//
//  Created by Alexey Popkov on 2/12/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

@objc public class PANumberKeyboardViewController: UIInputViewController
{
    @IBOutlet weak var keyboardView: UIView!
    
    fileprivate var privateFont = UIFont.systemFont(ofSize: 19)
    fileprivate var privateAllowDecimalPoint = false
    fileprivate var privateDecimalPointAsComma = false
    
    fileprivate var selectedTextButtonBackgroundImage:UIImage?
    fileprivate var selectedBackspaceButtonBackgroundImage:UIImage?
    fileprivate var selectedReturnButtonBackgroundImage:UIImage?
    
    public var backspaceAction:(() -> Void)?
    public var newTextAction:((_ text: String) -> Void)?
    public var returnAction:(() -> Void)?
    public var dismissAction:(() -> Void)?
    
    @IBOutlet weak var backspaceButton: PADecimalKeyboardBackspaceButton!
    @IBOutlet weak var returnButton: PADecimalKeyboardReturnButtonButton!
    @IBOutlet weak var dismissButton: PADecimalKeyboardDismissButton!
    
    @IBOutlet weak var doubleZeroButton: PADecimalKeyboardDoubleZeroButton!
    
    @IBOutlet weak var zeroButton: PADecimalKeyboardZeroButton!
    //    @IBOutlet weak fileprivate var zeroBigButton: PADecimalKeyboardZeroButton!
    //@IBOutlet weak fileprivate var zeroSmallButton: PADecimalKeyboardZeroButton!
    
    class public func createDecimalKeyboard() -> PANumberKeyboardViewController
    {
        // object_getClass(PANumberKeyboardViewController)
        let nib = UINib(nibName: "PANumberKeyboardViewController", bundle: Bundle(for: PANumberKeyboardViewController.self))
        let objects = nib.instantiate(withOwner: self, options: nil)
        let vc = objects[0] as! PANumberKeyboardViewController;
        return vc
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        configureKeyboard()
    }
    
    private func configureKeyboard()
    {
        configureSelectedButtonBackgroundImages()
        //configureDecimalPointButton()
    }
    
    override public func updateViewConstraints()
    {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override public func textWillChange(_ textInput: UITextInput?)
    {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override public func textDidChange(_ textInput: UITextInput?)
    {
        // The app has just changed the document's contents, the document context has been updated.
    }
    @IBAction func buttonPressedAction(_ sender: PADecimalKeyboardButton) {
        processActionType(actionType: sender.theButtonActionType())
        processNewText(text: sender.theButtonText())
    }
}

extension PANumberKeyboardViewController
{
//
//    @IBAction func buttonPressedAction2(button: PADecimalKeyboardButton)
//    {
//        processActionType(actionType: button.theButtonActionType())
//        processNewText(text: button.theButtonText())
//    }
}

// MARK: - Configuration Setters
extension PANumberKeyboardViewController
{
    public var textFont: UIFont {
        get {
            return privateFont
        }
        
        set(newValue) {
            privateFont = newValue
            configureButtonsFont(font: privateFont)
        }
    }
    
    
    public var allowDecimalPoint:Bool {
        get {
            return privateAllowDecimalPoint
        }
        set(newValue) {
            privateAllowDecimalPoint = newValue
            //configureDecimalPointButton()
        }
    }
    
    public var decimalPointAsComma:Bool {
        get {
            return privateDecimalPointAsComma
        }
        set(newValue) {
            privateDecimalPointAsComma = newValue
            //configureDecimalPointButton()
        }
    }
    
    public var textButtons:[UIButton] {
        get {
            var buttons = Array<UIButton>()
            
            for theView in keyboardView.subviews
            {
                if let _ = theView as? PADecimalKeyboardTextButton
                {
                    buttons.append(theView as! PADecimalKeyboardTextButton)
                }
            }
            
            return buttons
        }
    }
    
    public var numberKeyboardReturnButton:UIButton {
        get {
            return returnButton
        }
    }
    
    public var numberKeyboardBackspaceButton:UIButton {
        get {
            return backspaceButton
        }
    }
    
    public var numberKeyboardView:UIView {
        get {
            return keyboardView
        }
    }
    
    public var allButtons:[UIButton] {
        get {
            var buttons = self.textButtons
            
            buttons.append(backspaceButton)
            buttons.append(returnButton)
            buttons.append(dismissButton)
            
            return buttons
        }
    }

    public func setSelectedTextButtonBackgroundImage(image:UIImage) {
        selectedTextButtonBackgroundImage = image
        configureSelectedButtonBackgroundImages()
    }
    
    public func setSelectedBackspaceButtonBackgroundImage(image:UIImage) {
        selectedBackspaceButtonBackgroundImage = image
        configureSelectedButtonBackgroundImages()
    }
    
    public func setSelectedReturnButtonBackgroundImage(image:UIImage) {
        selectedReturnButtonBackgroundImage = image
        configureSelectedButtonBackgroundImages()
    }
    
    public func setSelectedTextButtonBackgroundColor(color:UIColor) {
        selectedTextButtonBackgroundImage = PANumberKeyboardViewController.createWithColor(color: color)
        configureSelectedButtonBackgroundImages()
    }
    
    public func setSelectedBackspaceButtonBackgroundColor(color:UIColor) {
        selectedBackspaceButtonBackgroundImage = PANumberKeyboardViewController.createWithColor(color: color)
        configureSelectedButtonBackgroundImages()
    }
    
    public func setSelectedReturnButtonBackgroundColor(color:UIColor) {
        selectedReturnButtonBackgroundImage = PANumberKeyboardViewController.createWithColor(color: color)
        configureSelectedButtonBackgroundImages()
    }
}

// MARK: - Private
extension PANumberKeyboardViewController
{
//    fileprivate func configureDecimalPointButton()
//    {
//        dotButton.isHidden = !privateAllowDecimalPoint
//        zeroSmallButton.isHidden = !privateAllowDecimalPoint
//        zeroBigButton.isHidden = privateAllowDecimalPoint
//        dotButton.decimalPointAsComma = decimalPointAsComma
//    }
//
//    fileprivate func configureZeroButtons() {
//
//    }
    fileprivate func configureButtonsFont(font: UIFont) {
        for button in allButtons {
            button.titleLabel?.font = font
        }
    }
    fileprivate func processActionType(actionType:ButtonActionType?)
    {
        guard let theActionType = actionType else {
            return
        }
        
        switch theActionType
        {
        case .backspace:
            processBackspace()
        case .returnButton:
            processReturn()
        case .dismiss:
            processDismiss()
        }
        
        
    }
    
    private func processBackspace()
    {
        if let theBackspaceAction = backspaceAction
        {
            self.textDocumentProxy.deleteBackward()
            theBackspaceAction()
        } else {
            self.textDocumentProxy.deleteBackward()
        }
    }
    
    private func processReturn()
    {
        if let theReturnAction = returnAction {
            theReturnAction()
        }
    }
    private func processDismiss() {
        if let theDismissAction = dismissAction {
            theDismissAction()
        }
        
    }
    fileprivate func processNewText(text:String?)
    {
        guard let theText = text else {
            return
        }
        
        self.textDocumentProxy.insertText(theText)
        
        if let theNewTextAction = newTextAction
        {
            theNewTextAction(theText)
        }
    }
    
    fileprivate func defaultSelectedButtonImage() -> UIImage
    {
        struct imageInstance {
            static let image = PANumberKeyboardViewController.createWithColor(color: UIColor.black)
        }
        
        return imageInstance.image
    }
    
    fileprivate func configureSelectedButtonBackgroundImages()
    {
        if let theImage = selectedTextButtonBackgroundImage {
            setTextButtonsSelectedButtonBackgroundImage(image: theImage)
        } else {
            selectedTextButtonBackgroundImage = defaultSelectedButtonImage()
            setTextButtonsSelectedButtonBackgroundImage(image: selectedTextButtonBackgroundImage!)
        }
        
        if let theImage = selectedReturnButtonBackgroundImage {
            setSelectedButtonImage(button: returnButton, image:theImage)
        } else {
            selectedReturnButtonBackgroundImage = defaultSelectedButtonImage()
            setSelectedButtonImage(button: returnButton, image:selectedReturnButtonBackgroundImage!)
        }
        
        if let theImage = selectedBackspaceButtonBackgroundImage {
            setSelectedButtonImage(button: backspaceButton, image:theImage)
        } else {
            selectedBackspaceButtonBackgroundImage = defaultSelectedButtonImage()
            setSelectedButtonImage(button: backspaceButton, image:selectedBackspaceButtonBackgroundImage!)
        }
    }
    
    private func setTextButtonsSelectedButtonBackgroundImage(image:UIImage)
    {
        for theView in keyboardView.subviews
        {
            if let _ = theView as? PADecimalKeyboardTextButton
            {
                let button = theView as! PADecimalKeyboardTextButton
                setSelectedButtonImage(button: button, image:image)
            }
        }
    }
    
    private func setSelectedButtonImage(button:UIButton, image:UIImage)
    {
        button.setBackgroundImage(image, for: .selected)
        button.setBackgroundImage(image, for: .highlighted)
    }
}

// MARK: - Tools
extension PANumberKeyboardViewController
{
    fileprivate class func createWithColor(color:UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

