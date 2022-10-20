//
//  PostListController.swift
//  RoomMate
//
//  Created by Rushikesh Potdar on 07/10/22.
//

import UIKit

class PostListController: UIViewController {
    let loader = Loader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    @IBOutlet weak var postTable: UITableView!
    
    var posts : [Post] = []
    let postVM = PostViewModel()
    var isFromMyPost : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFromMyPost{
            self.title = "My Post"
            loader.isHidden = false
            self.view.addSubview(loader)
            loader.startAnimatngLoader()
            postVM.getCurrentUserPosts { arrayOfPosts in
                self.posts.append(contentsOf: arrayOfPosts)
                self.loader.stopAnimatingLoader()
                self.loader.isHidden = true
                DispatchQueue.main.async {
                    self.postTable.reloadData()
                }
            }
        }else{
            loader.isHidden = false
            self.view.addSubview(loader)
            loader.startAnimatngLoader()
            postVM.getAllPost { arrayOfPosts in
                self.posts.append(contentsOf: arrayOfPosts)
                self.loader.stopAnimatingLoader()
                self.loader.isHidden = true
                DispatchQueue.main.async {
                    self.postTable.reloadData()
                }
            }
        }
    }
}


extension PostListController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTable.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else{return UITableViewCell()}
        let post = posts[indexPath.row]
        cell.addressLabel.text = post.fullAddress
        cell.aptLabel.text = post.appartmentName
        cell.extRoommatesCounterLabel.text = post.existingRoommates
        cell.reqRoommatesCounterLabel.text = post.requiredRoommates
        cell.monthlyRent.text = "₹" + post.monthlyRent
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailPostController") as? DetailPostController else {return}
        detailVC.post = posts[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
