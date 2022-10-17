//
//  PostViewController.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 12/08/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class PostViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var aptNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var stateDropdown: UIPickerView!
    @IBOutlet weak var cityDropdown: UIPickerView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var existingRoommateTextField: UITextField!
    @IBOutlet weak var requiredRoommateTextField: UITextField!
    
    let postVM = PostViewModel()
    let storage = Storage.storage()
    let imagePicker = UIImagePickerController()
    var phototUrls : [String] = []
    var photos : [UIImage] = []
    
    @IBOutlet weak var pickPhotoBtnOutlet: UIButton!
    @IBOutlet weak var viewPhotoBtnOutlet: UIButton!
    @IBOutlet weak var amminitiesTextField: UITextField!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var postBtnOutlet: UIButton!
    
    
    @IBAction func existingRoommateCounter(_ sender: UIStepper) {
        existingRoommateTextField.text = String(Int(sender.value))
    }
    @IBAction func requiredRoommateCounter(_ sender: UIStepper) {
        requiredRoommateTextField.text = String(Int(sender.value))
    }
    @IBOutlet weak var monthlyRentTextField: UITextField!
    
    @IBAction func pickPhotoButton(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func viewPhotoButton(_ sender: UIButton) {
        guard let photoVC = storyboard?.instantiateViewController(withIdentifier: "PhotoCollectionController") as? PhotoCollectionController else{return}
        photoVC.photos = photos
        navigationController?.pushViewController(photoVC, animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        checkInputs()
        
    }
    
    let stateList = ["- State -","MH", "GA", "GJ", "MP", "UP", "DL", "KL", "KA"]
    let cityList = ["- City -","Pune", "Mumbai", "Nashik","Dhule","Jalgoan","Kolhapur","Satara"]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup()
    {
        imagePicker.delegate = self
        aptNameTextField.delegate = self
        addressTextField.delegate = self
        emailTextField.delegate = self
        mobileTextField.delegate = self
        pincodeTextField.delegate = self
        monthlyRentTextField.delegate = self
        stateTextField.delegate = self
        stateDropdown.delegate = self
        stateDropdown.dataSource = self
        stateDropdown.frame.size.height = 0
        stateDropdown.isHidden = true
        stateDropdown.alpha = 0.0
        stateDropdown.layer.cornerRadius = 10
        stateDropdown.layer.masksToBounds = true
        
        //cityDropDown PickerView
        
        cityDropdown.delegate = self
        cityDropdown.dataSource = self
        cityDropdown.frame.size.height = 0
        cityDropdown.isHidden = true
        cityDropdown.alpha = 0.0
        cityDropdown.layer.cornerRadius = 10
        cityDropdown.layer.masksToBounds = true
        
        //
        existingRoommateTextField.text = "0"
        requiredRoommateTextField.text = "0"
        emailTextField.text = Auth.auth().currentUser?.email!
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        containerView.addGestureRecognizer(tap)
        UIExtentions.roundedButtonWithShadow(button: pickPhotoBtnOutlet)
        UIExtentions.roundedButtonWithShadow(button: viewPhotoBtnOutlet)
        UIExtentions.roundedButtonWithShadow(button: cancelBtnOutlet)
        UIExtentions.roundedButtonWithShadow(button: postBtnOutlet)
        
        UIExtentions.roundTextFieldWithShadow(textField: aptNameTextField)
        UIExtentions.roundTextFieldWithShadow(textField: addressTextField)
        UIExtentions.roundTextFieldWithShadow(textField: emailTextField)
        UIExtentions.roundTextFieldWithShadow(textField: mobileTextField)
        UIExtentions.roundTextFieldWithShadow(textField: pincodeTextField)
        UIExtentions.roundTextFieldWithShadow(textField: cityTextField)
        UIExtentions.roundTextFieldWithShadow(textField: stateTextField)
        UIExtentions.roundTextFieldWithShadow(textField: amminitiesTextField)
        UIExtentions.roundTextFieldWithShadow(textField: monthlyRentTextField)
    }
    
    func checkInputs(){
        var msg = ""
        if Validation.isValidAptName(aptname: aptNameTextField.text!) && Validation.isValidPincode(pincode: pincodeTextField.text!) && Validation.isValidAddress(address: addressTextField.text!) && Validation.isValidMobileNumber(mobile: mobileTextField.text!) && Validation.isValidAmenities(amenities: amminitiesTextField.text!){
            
            let startDate = Date.now
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .second, value: 19800, to: startDate)
            let email = Auth.auth().currentUser?.email!
            print(email!)
            
            postVM.addNewPost(post: Post(appartmentName: aptNameTextField.text!, amenities: amminitiesTextField.text!, address: addressTextField.text!, city: cityTextField.text!, state: stateTextField.text!, pincode: pincodeTextField.text!, existingRoommates: existingRoommateTextField.text!, requiredRoommates: requiredRoommateTextField.text!, monthlyRent: monthlyRentTextField.text!, photos: ["google.com"], mobile: mobileTextField.text!, email: email!, time: date!)) { done in
                if done{
                    print("new record has been added sucessfully...")
                }else{
                    print("something went wrong...!")
                }
            }
            
        }else{
            if Validation.isValidAptName(aptname: aptNameTextField.text!) == false{
                aptNameTextField.layer.borderWidth = 1.2
                aptNameTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "appartment name is not valid. \n"
            }
            if Validation.isValidPincode(pincode: pincodeTextField.text!) == false{
                pincodeTextField.layer.borderWidth = 1.2
                pincodeTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "pincode is invalid . \n"
            }
            if Validation.isValidAddress(address: addressTextField.text!) == false{
                addressTextField.layer.borderWidth = 1.2
                addressTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "address should not empty. \n"
            }
            if Validation.isValidMobileNumber(mobile: mobileTextField.text!) == false{
                mobileTextField.layer.borderWidth = 1.2
                mobileTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "mobile number is invalid. \n"
            }
            if Validation.isValidAmenities(amenities: amminitiesTextField.text!) == false{
                amminitiesTextField.layer.borderWidth = 1.2
                amminitiesTextField.layer.borderColor = UIColor.red.cgColor
                //msg = msg + "mobile should not empty, "
            }
            if Validation.isValidMonthlyRent(rent: monthlyRentTextField.text!) == false{
                monthlyRentTextField.layer.borderWidth = 1.2
                monthlyRentTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "monthly rent should not be empty or zero. \n"
            }
            if Validation.isValidRequiredRoomate(roommate: requiredRoommateTextField.text!) == false{
                requiredRoommateTextField.layer.borderWidth = 1.2
                requiredRoommateTextField.layer.borderColor = UIColor.red.cgColor
                msg = msg + "required roommate should not be zero. \n"
            }

            let action = UIAlertAction(title: "Ok", style: .default)
            CustomAlert.openAlert(title: "Oops", message: msg, actions: [action], controller: self)
        }
    }
    
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == stateDropdown
        {
            return stateList.count
        }
        else
        {
            return cityList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //self.view.endEditing(true)
        if pickerView == stateDropdown
        {
            self.view.resignFirstResponder()
            return stateList[row]
        }
        else if pickerView == cityDropdown
        {
            self.view.resignFirstResponder()
            return cityList[row]
        }
        
        else
        {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == stateDropdown
        {
            self.stateTextField.text = stateList[row]
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.stateDropdown.alpha = 0.0
            }
        completion: { done in
            if done{
                self.stateDropdown.isHidden = true
            }
        }
        }
        
        else if pickerView == cityDropdown
        {
            self.cityTextField.text = cityList[row]
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.cityDropdown.alpha = 0.0
            }
        completion: { done in
            if done{
                self.cityDropdown.isHidden = true
            }
        }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.stateTextField
        {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.stateDropdown.isHidden = false
                self.stateDropdown.alpha = 1
            }
            textField.endEditing(true)
        }
        
        else if textField == self.cityTextField
        {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.cityDropdown.isHidden = false
                self.cityDropdown.alpha = 1
            }
            textField.endEditing(true)
        }
        else if textField != self.stateTextField {
            //stateTextField.endEditing(true)
            //stateTextField.resignFirstResponder()
            stateDropdown.isHidden = true
        }
        else if textField != self.cityTextField
        {
            cityDropdown.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField
        {
        case mobileTextField:
            return Validation.restrictionForMobileNumber(entered: string)
            
        case pincodeTextField:
            return Validation.restrictionForPincode(entered: string, fullString: pincodeTextField.text!)
            
        case monthlyRentTextField :
            return Validation.restrictionForMonthlyRent(entered: string)
        
        default :
            //print("default")
            return true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else{return}
        
        dismiss(animated: true, completion: nil)
        postVM.uploadImage(selectedImage: selectedImage, vc: self) { urlString, error in
            if error == nil{
                self.phototUrls.append(urlString!)
                self.photos.append(selectedImage)
            }
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.stateDropdown.alpha = 0.0
            self.cityDropdown.alpha = 0.0
        }
    completion: { done in
        if done{
            self.stateDropdown.isHidden = true
            self.cityDropdown.isHidden = true
        }
    }
        
    }
    
}
