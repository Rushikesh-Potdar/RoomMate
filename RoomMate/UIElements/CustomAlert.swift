//
//  CustomAlert.swift
//  RoomMate
//
//  Created by shubhan.langade on 11/10/22.
//

import UIKit
struct CustomAlert
{
    static func openAlert(title : String, message : String, actions : [UIAlertAction], controller : UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(actions[0])
        //DispatchQueue.main.async {
            controller.present(alert, animated: true)
        //}
    }
}
