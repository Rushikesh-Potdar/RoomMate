//
//  Loader.swift
//  RoomMate
//
//  Created by shubhan.langade on 18/10/22.
//

import UIKit

class Loader : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    private func setupView(){
        self.backgroundColor = .white
        self.alpha = 0.5
        self.addSubview(myActivityIndicator)
        myActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        myActivityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        myActivityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myActivityIndicator.color = .orange
        myActivityIndicator.style = .large
    }
    
    func startAnimatngLoader(){
        myActivityIndicator.startAnimating()
    }
    
    func stopAnimatingLoader(){
        myActivityIndicator.stopAnimating()
    }
}
