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
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
}

extension PhotoCollectionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        let width = self.view.frame.size.width
        let cellWidth = width * 0.40
        cell.photo.translatesAutoresizingMaskIntoConstraints = false
        cell.photo.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
        cell.photo.heightAnchor.constraint(equalToConstant: cellWidth).isActive = true
        cell.photo.image = UIImage(named: "pexels-pixabay-60597")
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
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
