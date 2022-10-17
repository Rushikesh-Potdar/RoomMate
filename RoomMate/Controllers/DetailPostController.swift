//
//  DetailPostController.swift
//  RoomMate
//
//  Created by shubhan.langade on 17/10/22.
//

import UIKit

class DetailPostController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!
    
    @IBOutlet weak var aptNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    @IBOutlet weak var amminitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }

}

extension DetailPostController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoDetailCell", for: indexPath) as? PhotoDetailCell else {return UITableViewCell()}
        cell.singleImageView.image = UIImage(named: "CorrptedImage")
        PostViewModel().downloadImage(with: "") { myimage, err in
                cell.singleImageView.image = myimage
        }
        return cell
    }


}
