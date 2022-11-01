//
//  Post.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 09/10/22.
//

import Foundation

struct Post{
    let appartmentName : String
    let amenities : String
    let address : String
    let city : String
    let state : String
    let pincode : String
    let existingRoommates : String
    let requiredRoommates : String
    let monthlyRent : String
    let photos : [String]
    let mobile : String
    let email : String
    let time : Date
    var documentID = ""
    var fullAddress : String {
        get{
            return address + ", " + city + ", " + state + ", " + pincode
        }
    }
}
