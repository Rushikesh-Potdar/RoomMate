//
//  PostViewModel.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 09/10/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UIKit
import FirebaseStorage

class PostViewModel{
    let db = Firestore.firestore()
    
    func getAllPost(complition : @escaping ([Post])->()){
        let ref = db.collection("Posts")
        ref.getDocuments { querySnapshot, err in
            if err == nil{
                let result = querySnapshot!.documents
                let arrayOfPost = self.parsData(result: result)
                complition(arrayOfPost)
            }
        }
    }
    
    func addNewPost(post : Post,complition:@escaping (Bool)->()){
        db.collection("Posts").addDocument(data: ["address" : post.address, "amenities" : post.amenities, "apt_name" : post.appartmentName, "city" : post.city, "ext_roommates" : post.existingRoommates, "req_roommates" : post.requiredRoommates, "monthly_rent" : post.monthlyRent, "photos_url" : post.photos, "pincode" : post.pincode, "state" : post.state, "mobile" : post.mobile, "email" : post.email]) { err in
            if err == nil{
                //print("record has been added successfuly over the FB")
                complition(true)
            }else{
                complition(false)
            }
        }
    }
    
    private func parsData(result : [QueryDocumentSnapshot]) -> [Post]{
        
        var posts : [Post] = []
        for post in result{
            let addressLineOne =  post["address"] as! String
            let city = post["city"] as! String
            let state = post["state"] as! String
            let pincode = post["pincode"] as! String
            let aptName = post["apt_name"] as! String
            let extRoom = post["ext_roommates"] as! String
            let reqRoom = post["req_roommates"] as! String
            let monthlyrent = post["monthly_rent"] as! String
            let amenities = post["amenities"] as! String
            let photo_urls = post["photos_url"] as! [String]
            posts.append(Post(appartmentName: aptName, amenities: amenities, address: addressLineOne, city: city, state: state, pincode: pincode, existingRoommates: extRoom, requiredRoommates: reqRoom, monthlyRent: monthlyrent, photos: photo_urls, mobile: "888888888", email: "example@gmail.com", time: Date.now))
        }
        
        return posts
    }
    
    func getCurrentUserPosts(complition : @escaping ([Post])->()){
        guard let email = Auth.auth().currentUser?.email! else {return}
        let ref = db.collection("Posts").whereField("email", isEqualTo: email)
        ref.getDocuments { querySnapshot, err in
            if err == nil{
                let result = querySnapshot!.documents
                let arrayOfPost = self.parsData(result: result)
                complition(arrayOfPost)
            }
        }
    }
    
    func uploadImage(selectedImage : UIImage, vc : UIViewController, complition : @escaping (String?, Error?)->()) {
        let storage = Storage.storage()
        let randomUUID = UUID.init().uuidString
        let storageRef = storage.reference(withPath: "Photos/").child("\(randomUUID).jpeg")
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.25) else {return}
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        let alert = UIAlertController(title: "Uploading", message: "Image is uploading...", preferredStyle: .alert)
        
        let uploadingTask = storageRef.putData(imageData, metadata: uploadMetadata) { storageMetadata, error in
            if error == nil{
                //print(storageMetadata?.path as Any)
                storageRef.downloadURL { url, error in
                    if error == nil{
                        let urlString = url?.absoluteString
                        complition(urlString, nil)
                    }
                }
                alert.dismiss(animated: true, completion: nil)
            }else{
                print("error occured while uploading image\(String(describing: error?.localizedDescription))")
                complition(nil, error)
            }
        }
        
        let cancelUploading = UIAlertAction(title: "Cancel", style: .destructive) { action in
            uploadingTask.cancel()
        }
        alert.addAction(cancelUploading)
        vc.present(alert, animated: true)
        
    }
    
    func downloadImage(with url : String, complition : @escaping (UIImage, Error?)->()) {
        let image = UIImage(named: "CorrptedImage")
        let storage = Storage.storage()
        let fsReferance = storage.reference(forURL:"https://firebasestorage.googleapis.com/v0/b/roommate-3dfa6.appspot.com/o/Photos%2FFF60C403-AAB4-4B7A-B013-07FA0A299DA5.jpeg?alt=media&token=5e953401-ea14-4ba8-8cc1-9d1f8f17f93d")
        fsReferance.getData(maxSize: 3 * 1024 * 1024) { imageData, error in
            if error == nil
            {
                print(imageData)
                complition(UIImage(data: imageData!)!, nil)
            }
            else
            {
                print(error?.localizedDescription)
                complition(image!, error!)
            }
        }
    }
}
