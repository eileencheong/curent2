//
//  ViewController.swift
//  CURent
//
//  Created by Jaewon Sim on 4/25/18.
//  Copyright © 2018 CURent. All rights reserved.
//


//GID Login Screen

import UIKit
import GoogleSignIn
import ChameleonFramework

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    var signInButton: GIDSignInButton!
    var titleLabel: UILabel!
    var sloganLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = GradientColor(.topToBottom, frame: UIScreen.main.bounds, colors: [HexColor("#19d7fb")!, HexColor("#1e63ee")!])
        view.backgroundColor?.withAlphaComponent(0.6)
        navigationController?.isNavigationBarHidden = true
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "goldwin_smith.jpg")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
//        backgroundImage.tintColor = GradientColor(.topToBottom, frame: UIScreen.main.bounds, colors: [HexColor("#19d7fb")!, HexColor("#1e63ee")!])
//        backgroundImage.tintColor.withAlphaComponent(0.6)
        
        titleLabel = UILabel()
        titleLabel.text = "CURent"
        titleLabel.textColor = ContrastColorOf(view.backgroundColor!, returnFlat: true)
        titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .light)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        sloganLabel = UILabel()
        sloganLabel.lineBreakMode = .byWordWrapping
        sloganLabel.numberOfLines = 3
        sloganLabel.text = "Peer-to-peer subleasing platform for Cornellians"
        sloganLabel.textColor = ContrastColorOf(view.backgroundColor!, returnFlat: true)
        sloganLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sloganLabel)
        
        signInButton = GIDSignInButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(signInButton)
        
        setUpConstraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280)
            ])
        
        NSLayoutConstraint.activate([
            sloganLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            sloganLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sloganLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
            ])
        
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: sloganLabel.leadingAnchor),
            signInButton.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 32)
            ])
        
    }


}

