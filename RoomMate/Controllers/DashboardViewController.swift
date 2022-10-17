//
//  DashboardViewController.swift
//  RoomMate
//
//  Created by shubhan.langade on 08/08/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var room: UIButton!
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.4, options: .curveEaseOut) {
            self.logo.transform = CGAffineTransform.identity
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIExtentions.roundedButtonWithShadow(button: room)
        UIExtentions.roundedButtonWithShadow(button: post)
        room.layer.cornerRadius = room.frame.size.height/2
        post.layer.cornerRadius = room.frame.size.height/2
        self.logo.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
        
        let myPostBtn = UIBarButtonItem(image: UIImage(systemName: "pin.circle"), style: .plain, target: self, action: #selector(goToPostListVC))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem = myPostBtn
//        let toolBar = UIToolbar();
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = .black
//        toolBar.backgroundColor = .white
//        toolBar.sizeToFit()
    }
    @objc func goToPostListVC(){
        let listVC = storyboard?.instantiateViewController(withIdentifier: "PostListController") as! PostListController
        listVC.isFromMyPost = true
        navigationController?.pushViewController(listVC, animated: true)
    }
    @IBAction func findARoomTapped(_ sender: UIButton) {
        guard let postListVC = storyboard?.instantiateViewController(withIdentifier: "PostListController") as? PostListController else{return}
        navigationController?.pushViewController(postListVC, animated: true)
    }
    
    @IBAction func addAPostTapped(_ sender: Any) {
        guard let postViewVC = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController else{return}
        navigationController?.pushViewController(postViewVC, animated: true)
    }

}
