//
//  PhotoViewCell.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 17/10/22.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {

    var deleteImageAction : (()->())?
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func deleteImageButtonPressed(_ sender: UIButton) {
        guard let closure = deleteImageAction else {return}
        closure()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
