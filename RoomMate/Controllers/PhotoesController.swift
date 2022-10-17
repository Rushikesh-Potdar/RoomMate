//
//  PhotoesController.swift
//  RoomMate
//
//  Created by shubhan.langade on 13/10/22.
//

import UIKit

class PhotoesController: UIViewController {

    @IBOutlet weak var photoCollection: UICollectionView!
    var photoes = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
}

extension PhotoesController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photo.image = UIImage(named: "pexels-pixabay-60597")
        return cell
        
    }
    
    
}
