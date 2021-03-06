//
//  ViewController.swift
//  PANumberKeyboardExample
//
//  Created by Alexey Popkov on 2/22/16.
//  Copyright © 2016 Alexey Popkov. All rights reserved.
//

import UIKit
import PANumberKeyboard

class ViewController: UIViewController, UITextFieldDelegate
{
    var keyboardVC:PANumberKeyboardViewController!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureKeyboard()
    }
    
    func configureKeyboard()
    {
        self.keyboardVC = PANumberKeyboardViewController.createDecimalKeyboard()
        self.keyboardVC.allowDecimalPoint = true
        self.keyboardVC.decimalPointAsComma = true
        //        self.keyboardVC.setSelectedTextButtonBackgroundColor(UIColor.greenColor())
        //        self.keyboardVC.setSelectedReturnButtonBackgroundColor(UIColor.whiteColor())
        //        self.keyboardVC.setSelectedBackspaceButtonBackgroundColor(UIColor.blackColor())
        
        self.keyboardVC.numberKeyboardReturnButton.setTitle("Tender", for: .normal)
        self.keyboardVC.textFont = UIFont(name: "Arial", size: 30)!
//        for button in self.keyboardVC.allButtons
//        {
//            let layer = button.layer
//            layer.masksToBounds = true
//            layer.cornerRadius = 2
//        }
        
        self.keyboardVC.returnAction = { (Void) -> Void in
            // TODO: handle return button pressed
            //self.textField.resignFirstResponder()
            
        }
        
        self.keyboardVC.dismissAction = { (Void) -> Void in
            // TODO: handle return button pressed
            self.textField.resignFirstResponder()
            
        }
        self.keyboardVC.backspaceAction = { (Void) -> Void in
            // TODO: handle backspace button pressed
        }
        
        self.keyboardVC.newTextAction = { (text:String) -> Void in
            // TODO: handle insert new text
            
        }
        
        textField.inputView = self.keyboardVC.numberKeyboardView
        if #available(iOS 9.0, *) {
            self.textField.inputAssistantItem.leadingBarButtonGroups.removeAll()
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            self.textField.inputAssistantItem.trailingBarButtonGroups.removeAll()
        } else {
            // Fallback on earlier versions
        }
        textField.delegate = self
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.keyboardVC .dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print(range, terminator: "")
        return true;
    }
}


