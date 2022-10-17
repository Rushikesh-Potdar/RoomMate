//
//  UIExtentions.swift
//  RoomMate
//
//  Created by shubhan.langade on 03/08/22.
//
import UIKit
class UIExtentions{
    
    static func roundTextFieldWithShadow(textField : UITextField) {
        textField.borderStyle = .none

            //To apply corner radius
        textField.layer.cornerRadius = textField.frame.size.height / 2

            //To apply border
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 3.0
        textField.layer.shadowOffset = CGSize.zero // Use any CGSize
        textField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    static func counterTextFieldsDropShadow(textField:UITextField){
        textField.borderStyle = .none

            //To apply corner radius
        textField.layer.cornerRadius = 4

            //To apply border
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 3.0
        textField.layer.shadowOffset = CGSize.zero // Use any CGSize
        textField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    static func roundedButtonWithShadow(button:UIButton){
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
    }
    
}
