//
//  SignUpViewController.swift
//  RoomMate
//
//  Created by shubhan.langade on 04/08/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtnOutlet: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIExtentions.roundTextFieldWithShadow(textField: emailTextField)
        UIExtentions.roundTextFieldWithShadow(textField: passwordTextField)
        UIExtentions.roundTextFieldWithShadow(textField: confirmPasswordTextField)
        UIExtentions.roundedButtonWithShadow(button: signUpBtnOutlet)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        confirmPasswordErrorLabel.isHidden = true
        
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        if Validation.isValidEmail(email: emailTextField.text!) && Validation.isValidPassword(password: passwordTextField.text!) && confirmPasswordTextField.text! == passwordTextField.text!
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                //print(authResult?.user.email! as Any)
                if error == nil{
                    self.navigationController?.popToRootViewController(animated: true)
                }else{
                    print(error!.localizedDescription)
                    CustomAlert.openAlert(title: "Alert!", message: error!.localizedDescription, actions: [UIAlertAction(title: "Retry", style: .destructive, handler: nil)], controller: self)
                }
                
            }
        }
        else {
//            print("Passord is mismatch")
//            CustomAlert.openAlert(title: "Alert!", message: "Passord is mismatch and it should not be empty", actions: [UIAlertAction(title: "Retry", style: .destructive, handler: nil)], controller: self)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension SignUpViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == emailTextField{
            if Validation.isValidEmail(email: textField.text!){
                emailErrorLabel.isHidden = true
                UIExtentions.roundTextFieldWithShadow(textField: emailTextField)
            }else{
                emailErrorLabel.isHidden = false
                UIExtentions.errorTextFieldWithShadow(textField: emailTextField)
                emailErrorLabel.text = "Please enter valid email"
                
            }
        } else if textField == passwordTextField{
            if Validation.isValidPassword(password: textField.text!){
                passwordErrorLabel.isHidden = true
                UIExtentions.roundTextFieldWithShadow(textField: passwordTextField)
            }else{
                passwordErrorLabel.isHidden = false
                UIExtentions.errorTextFieldWithShadow(textField: passwordTextField)
                passwordErrorLabel.text = "Please enter valid password"
            }
        } else {
            if passwordTextField.text != confirmPasswordTextField.text{
                confirmPasswordErrorLabel.isHidden = false
                UIExtentions.errorTextFieldWithShadow(textField: confirmPasswordTextField)
                confirmPasswordErrorLabel.text = "Confirm password is not match with entered password"
            }else{
                UIExtentions.roundTextFieldWithShadow(textField: confirmPasswordTextField)
                confirmPasswordErrorLabel.isHidden = true
            }
        }
    }
}
