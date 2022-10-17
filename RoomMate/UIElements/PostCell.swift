//
//  PostCell.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 07/10/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var aptLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var extRoommatesCounterLabel: UILabel!
    @IBOutlet weak var reqRoommatesCounterLabel: UILabel!
    @IBOutlet weak var monthlyRent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
