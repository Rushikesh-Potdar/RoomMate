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
    let firebaseAuth = Auth.auth()
    var currentUserEmail : String?{
        get{
            guard let email = Auth.auth().currentUser?.email! else {return nil}
            return email
        }
    }
    
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
            let mobile = post["mobile"] as! String
            let email = post["email"] as! String
            let dcID = post["dcId"] as! String
            posts.append(Post(appartmentName: aptName, amenities: amenities, address: addressLineOne, city: city, state: state, pincode: pincode, existingRoommates: extRoom, requiredRoommates: reqRoom, monthlyRent: monthlyrent, photos: photo_urls, mobile: mobile, email: email, time: Date.now, documentID: dcID))
        }
        
        return posts
    }
    
    func addNewPost(post : Post,complition:@escaping (Bool)->()){
        let document = db.collection("Posts").document()
        document.setData(["dcId": document.documentID, "address" : post.address, "amenities" : post.amenities, "apt_name" : post.appartmentName, "city" : post.city, "ext_roommates" : post.existingRoommates, "req_roommates" : post.requiredRoommates, "monthly_rent" : post.monthlyRent, "photos_url" : post.photos, "pincode" : post.pincode, "state" : post.state, "mobile" : post.mobile, "email" : post.email]) { err in
            if err == nil{
                //print("record has been added successfuly over the FB")
                complition(true)
            }else{
                complition(false)
            }
        }
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
    
    func uploadImage(selectedImage : UIImage, vc : UIViewController, complition : @escaping (String?, String?, Error?)->()) {
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
                        complition(urlString, "\(randomUUID).jpeg", nil)
                    }
                }
                alert.dismiss(animated: true, completion: nil)
            }else{
                print("error occured while uploading image\(String(describing: error?.localizedDescription))")
                complition(nil, nil, error)
            }
        }
        
        let cancelUploading = UIAlertAction(title: "Cancel", style: .destructive) { action in
            uploadingTask.cancel()
        }
        alert.addAction(cancelUploading)
        vc.present(alert, animated: true)
        
    }
    
    func deleteImage(names : [String]){
        let storage = Storage.storage()
        for name in names{
            let storageRef = storage.reference(withPath: "Photos/").child(name)
            storageRef.delete { err in
                if let e = err{
                    print(e.localizedDescription)
                }else{
                    print("file deleted successfully")
                }
            }
        }
    }
    
    func urlToFileName(urls:[String]) -> [String]{
        var imageNames : [String] = []
        for url in urls{
            
            let Id1 = url.substring(from: url.range(of: "%2F")!.upperBound)

            let final = String(Id1.reversed())

            let f = final.substring(from: final.range(of: "tla?")!.upperBound)

            let fileName = String(f.reversed())
            imageNames.append(fileName)
        }
        return imageNames
    }
    
    func downloadImage(with url : String, complition : @escaping (UIImage, Error?)->()) {
        let image = UIImage(named: "CorrptedImage")
        let storage = Storage.storage()
//        let fsReferance = storage.reference(forURL:"https://firebasestorage.googleapis.com/v0/b/roommate-3dfa6.appspot.com/o/Photos%2FFF60C403-AAB4-4B7A-B013-07FA0A299DA5.jpeg?alt=media&token=5e953401-ea14-4ba8-8cc1-9d1f8f17f93d")
        let fsReferance = storage.reference(forURL:url)
        fsReferance.getData(maxSize: 3 * 1024 * 1024) { imageData, error in
            if error == nil
            {
                //print(imageData)
                complition(UIImage(data: imageData!)!, nil)
            }
            else
            {
                //print(error?.localizedDescription)
                complition(image!, error!)
            }
        }
    }
    func logout(){
        do{
            try firebaseAuth.signOut()
        }catch let signoutError as NSError{
            print("Error signing out: %@", signoutError)
        }
    }
    /*
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
     let mobile = post["mobile"] as! String
     let email = post["email"] as! String
     let dcID = post["dcId"] as! String
     */
    func updatePost(for documentID : String, with newData : Post){
        let ref = db.collection("Posts")
        ref.document(documentID).updateData(["address" : newData.address, "amenities" : newData.amenities, "apt_name" : newData.appartmentName, "ext_roommates" : newData.existingRoommates, "req_roommates" : newData.requiredRoommates, "monthly_rent" : newData.monthlyRent, "photos_url" : newData.photos, "pincode" : newData.pincode, "mobile" : newData.mobile]) { err in
            if let er = err{
                print("Error updating document \(er.localizedDescription)")
            }else{
                print("updated successfully")
            }
        }
        
    }
    
    func deletePost(post : Post){
        let imageNames = urlToFileName(urls: post.photos)
        deleteImage(names: imageNames)
        db.collection("Posts").document(post.documentID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
