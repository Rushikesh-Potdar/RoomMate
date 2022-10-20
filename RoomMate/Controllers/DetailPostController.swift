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
    
    var post : Post?
    private var photoArr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.delegate = self
        photoTableView.dataSource = self
        updateUI()
    }

    func updateUI(){
        guard let post = post else{return}
        aptNameLabel.text = post.appartmentName
        addressLabel.text = post.fullAddress
        emailLabel.text = post.email
        mobileLabel.text = post.mobile
        stateLabel.text = post.state
        cityLabel.text = post.city
        pincodeLabel.text = post.pincode
        amminitiesLabel.text = post.amenities
        photoArr.append(contentsOf: post.photos)
    }
}

extension DetailPostController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoDetailCell", for: indexPath) as? PhotoDetailCell else {return UITableViewCell()}
        cell.singleImageView.image = UIImage(named: "CorrptedImage")
        PostViewModel().downloadImage(with: photoArr[indexPath.row]) { myimage, err in
                cell.singleImageView.image = myimage
        }
        return cell
    }


}
