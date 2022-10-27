//
//  PhotoDetailCell.swift
//  RoomMate
//
//  Created by shubhan.langade on 17/10/22.
//

import UIKit

class PhotoDetailCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var singleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
