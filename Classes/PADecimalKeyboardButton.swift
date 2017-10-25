//
//  PADecimalKeyboardButton.swift
//  PACustomKeyboard
//
//  Created by Alexey Popkov on 2/18/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit

enum ButtonActionType:Int
{
    case backspace
    case returnButton
    case dismiss
}

protocol PADecimalKeyboardButtonProtocol
{
    func theButtonText() -> String?
    func theButtonActionType() -> ButtonActionType?
}

class PADecimalKeyboardButton: UIButton, PADecimalKeyboardButtonProtocol
{
    override func awakeFromNib() {
        self.layer.cornerRadius = 9.0
        self.clipsToBounds = true
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 9.0
//        self.layer.masksToBounds = true
        //self.layer.cornerRadius = 4.0
    }
    
    func theButtonText() -> String? {
        return nil
    }
    
    func theButtonActionType() -> ButtonActionType? {
        return nil
    }
}

class PADecimalKeyboardTextButton: PADecimalKeyboardButton
{
}

class PADecimalKeyboardZeroButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "0"
    }
}

class PADecimalKeyboardDoubleZeroButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "00"
    }
}

class PADecimalKeyboardOneButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "1"
    }
}

class PADecimalKeyboardTwoButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "2"
    }
}

class PADecimalKeyboardThreeButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "3"
    }
}

class PADecimalKeyboardFourButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "4"
    }
}

class PADecimalKeyboardFiveButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "5"
    }
}

class PADecimalKeyboardSixButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "6"
    }
}

class PADecimalKeyboardSevenButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "7"
    }
}

class PADecimalKeyboardEightButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "8"
    }
}

class PADecimalKeyboardNineButton: PADecimalKeyboardTextButton
{
    override func theButtonText() -> String? {
        return "9"
    }
}

class PADecimalKeyboardDotButton: PADecimalKeyboardTextButton
{
    private var privateDecimalPointAsComma = false
    
    private var privateDotText = "."
    
    var decimalPointAsComma:Bool {
        get {
            return privateDecimalPointAsComma
        }
        set(newValue) {
            privateDecimalPointAsComma = newValue
            
            if decimalPointAsComma == true {
                privateDotText = ","
                configureButtonTitle(title: privateDotText)
            } else {
                privateDotText = "."
                configureButtonTitle(title: privateDotText)
            }
        }
    }
    
    private func configureButtonTitle(title:String)
    {
        self.setTitle(title, for: .selected)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .normal)
    }
    
    override func theButtonText() -> String? {
        return privateDotText
    }
}

class PADecimalKeyboardBackspaceButton: PADecimalKeyboardButton
{
    override func theButtonActionType() -> ButtonActionType? {
        return ButtonActionType.backspace
    }
}

class PADecimalKeyboardDismissButton: PADecimalKeyboardButton
{
    override func theButtonActionType() -> ButtonActionType? {
        return ButtonActionType.dismiss
    }
}

class PADecimalKeyboardReturnButtonButton: PADecimalKeyboardButton
{
    override func theButtonActionType() -> ButtonActionType? {
        return ButtonActionType.returnButton
    }
}
