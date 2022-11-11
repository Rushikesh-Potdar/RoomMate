//
//  PhotoesController.swift
//  RoomMate
//
//  Created by shubhan.langade on 13/10/22.
//

import UIKit

class PhotoCollectionController: UIViewController {
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    
    var itemsPerRow : CGFloat = 3

    @IBOutlet weak var photoCollection: UICollectionView!
    
    var photos = [UIImage]()
    var passFlag : (([UIImage], [String], [String])->())?
    var imageNames = [String]()
    var phototUrls = [String]()
    let postVM = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        photoCollection.dataSource = self
        checkNumberOfPhotos()
    }
    override func viewDidDisappear(_ animated: Bool) {
        passFlag?(photos, phototUrls, imageNames)
    }
    
    func checkNumberOfPhotos(){
        if photos.isEmpty{
            photoCollection.isHidden = true
            let myLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width / 2) - 50 , y: (self.view.frame.size.height / 2) - 10 , width: 100, height: 20))
            myLabel.textAlignment = .center
            myLabel.text = "No Photos..."
            view.addSubview(myLabel)
        }
        else{
            photoCollection.isHidden = false
        }
    }
}

extension PhotoCollectionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        let width = self.view.frame.size.width
        let cellWidth = width * 0.40
        cell.photo.translatesAutoresizingMaskIntoConstraints = false
        cell.photo.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
        cell.photo.heightAnchor.constraint(equalToConstant: cellWidth).isActive = true
        cell.photo.image = photos[indexPath.row]
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.deleteImageAction = {
            self.postVM.deleteImage(names: [self.imageNames[indexPath.row]])
            
            self.photos.remove(at: indexPath.row)
            self.imageNames.remove(at: indexPath.row)
            self.phototUrls.remove(at: indexPath.row)
            self.photoCollection.reloadData()
            self.checkNumberOfPhotos()
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        let cellWidth = width * 0.40
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = self.view.frame.size.width
        let trailing = width * 0.080
        return UIEdgeInsets(top: 10, left: trailing, bottom: 1.0, right: trailing)
    }
    
    
}
