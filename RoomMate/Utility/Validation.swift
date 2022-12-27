//
//  Validation.swift
//  RoomMate
//
//  Created by shubhan.langade on 10/10/22.
//

import Foundation

class Validation
{
    static func isValidEmail(email : String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
    }
    
    static func isValidPassword(password : String) -> Bool
    {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            return passwordTest.evaluate(with: password)
    }
    
    static func isValidAptName(aptname: String)->Bool{
        if aptname.count > 2 && aptname.count <= 20{
            return true
        }
        else{
            return false
        }
    }
    
    static func isValidAddress(address: String)->Bool{
        if address.count > 10 && address.count <= 60{
            return true
        }
        else{
            return false
        }
    }
    
    static func isValidAmenities(amenities: String)->Bool{
        if amenities.count <= 100{
            return true
        }
        else{
            return false
        }
    }
    
    static func isValidMobileNumber(mobile: String)->Bool{
        if mobile.count == 10{
            return true
        }
        else{
            return false
        }
    }
    
    static func isValidMonthlyRent(rent: String)->Bool{
        let rentInt = Int(rent)
        if rentInt != 0{
            return true
        }
        else{
            return false
        }
    }
    
    static func isValidRequiredRoomate(roommate: String)->Bool{
        let roommateInt = Int(roommate)
        if roommateInt != 0{
            return true
        }
        else{
            return false
        }
    }
    
    static func restrictionForMobileNumber(entered string : String)-> Bool{
        
        if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                let isSpace = strcmp(char, "\\s")
                if (isBackSpace == -92) {
                    return true
                }else if (isSpace == -60){
                return false
            }
            }
        let allowedCharacters = CharacterSet(charactersIn:"+0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    static func isValidPincode(pincode: String)->Bool{
        if pincode.count == 6{
            return true
        }
        else{
            return false
        }
    }
    
    static func restrictionForPincode(entered string : String, fullString: String)-> Bool{
        
        if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                let isSpace = strcmp(char, "\\s")
                if (isBackSpace == -92) {
                    return true
                }else if (isSpace == -60){
                return false
            }
            }
        if fullString.count < 6{
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")//Here change this characters based on your requirement
                    let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        else{
            return false
        }
        
    }
    
    static func restrictionForMonthlyRent(entered string : String)-> Bool{
        
        if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                let isSpace = strcmp(char, "\\s")
                if (isBackSpace == -92) {
                    return true
                }else if (isSpace == -60){
                return false
            }
            }
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    
    static func restrictionForEmailID(entered string : String) -> Bool
    {
        if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                let isSpace = strcmp(char, "\\s")
                if (isBackSpace == -92) {
                    return true
                }else if (isSpace == -60){
                return false
            }
            let RISTRICTED_CHARACTERS = "₹"
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS)
                let inverted = set.inverted
                let filtered = string.components(separatedBy: inverted).joined(separator: "")
                return filtered != string
            }
        return true
    }
    
}
