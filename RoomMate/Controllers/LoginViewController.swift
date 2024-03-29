//
//  ViewController.swift
//  RoomMate
//
//  Created by shubhan.langade on 03/08/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loader = Loader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        
        // MARK: - Login Functionality with Session Handling
        if Validation.isValidEmail(email: emailTextField.text!) && Validation.isValidPassword(password: passwordTextField.text!){
            
            loader.isHidden = false
            self.view.addSubview(loader)
            loader.startAnimatngLoader()
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error == nil{
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    self.loader.stopAnimatingLoader()
                    guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else{return}
                    self.navigationController?.pushViewController(dashboardVC, animated: true)
                }else{
                    print(error?.localizedDescription ?? "error while login")
                    self.showAlert(with: error!.localizedDescription, and: "try again")
                    self.loader.stopAnimatingLoader()
                    self.loader.removeFromSuperview()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIExtentions.roundTextFieldWithShadow(textField: emailTextField)
        UIExtentions.roundTextFieldWithShadow(textField: passwordTextField)
        UIExtentions.roundedButtonWithShadow(button: loginButton)
        self.navigationItem.setHidesBackButton(true, animated: false)
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.isHidden = true
    }
    
    @IBAction func forgotPasswordBtnTapped(_ sender: UIButton) {
        //        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
        //            print(error?.localizedDescription)
        //        }
        alertToForgotPassword()
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else{return}
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func alertToForgotPassword() {
        
        let alert = UIAlertController(title: "Enter your registered Email.", message: "A link to change password will be send to your Email.", preferredStyle: .alert)
        
        alert.addTextField { field in
            self.emailTextField = field
            field.placeholder = "Email"
            field.keyboardType = .emailAddress
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            if let email = self.emailTextField?.text, !email.isEmpty {
                
                Auth.auth().sendPasswordReset(withEmail: self.emailTextField!.text!) { error in
                    
                    if let error = error
                    {
                        print("Error to reset password")
                        print(error.localizedDescription)
                        return
                    }
                    self.showAlert(with: "An email has been sent to your registered email ID.", and: "Okay")
                }
                
            }
            
        }
                                      
                                     ))
        present(alert, animated: true)
        
    }
    
    
}



extension LoginViewController{
    func showAlert(with msg : String, and singleActionTitile: String){
        let alert2 = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: singleActionTitile, style: .default) { act in
            self.dismiss(animated: true)
        }
        
        alert2.addAction(action)
        self.present(alert2, animated: true)
    }
}


extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == emailTextField{
//            emailErrorLabel.isHidden = false
//            emailErrorLabel.text = "this is a email text field "
//        }
        return true
    }
    
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
        }else{
            if Validation.isValidPassword(password: textField.text!){
                passwordErrorLabel.isHidden = true
                UIExtentions.roundTextFieldWithShadow(textField: passwordTextField)
            }else{
                passwordErrorLabel.isHidden = false
                UIExtentions.errorTextFieldWithShadow(textField: passwordTextField)
                passwordErrorLabel.text = "Please enter valid password"
            }
        }
    }
}
