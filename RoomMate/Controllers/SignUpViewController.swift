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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIExtentions.roundTextFieldWithShadow(textField: emailTextField)
        UIExtentions.roundTextFieldWithShadow(textField: passwordTextField)
        UIExtentions.roundTextFieldWithShadow(textField: confirmPasswordTextField)
        UIExtentions.roundedButtonWithShadow(button: signUpBtnOutlet)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        if passwordTextField.text! == confirmPasswordTextField.text! && passwordTextField.text != "" && confirmPasswordTextField.text != ""
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
            print("Passord is mismatch")
            CustomAlert.openAlert(title: "Alert!", message: "Passord is mismatch and it should not be empty", actions: [UIAlertAction(title: "Retry", style: .destructive, handler: nil)], controller: self)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
