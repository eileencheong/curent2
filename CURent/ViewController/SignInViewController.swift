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

class SignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    var backgroundGraphic: UIImageView!
    var signInButton: GIDSignInButton!
    var titleLabel: UILabel!
    var sloganLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        view.backgroundColor = GradientColor(.topToBottom, frame: UIScreen.main.bounds, colors: [HexColor("#19d7fb")!, HexColor("#1e63ee")!])
//        view.backgroundColor?.withAlphaComponent(0.6)
        backgroundGraphic = UIImageView(frame: UIScreen.main.bounds)
        backgroundGraphic.image = #imageLiteral(resourceName: "background")
        backgroundGraphic.contentMode = UIViewContentMode.scaleAspectFill
        view.insertSubview(backgroundGraphic, at: 0)
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "goldwin_smith.jpg")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
//        backgroundImage.tintColor = GradientColor(.topToBottom, frame: UIScreen.main.bounds, colors: [HexColor("#19d7fb")!, HexColor("#1e63ee")!])
//        backgroundImage.tintColor.withAlphaComponent(0.6)
        
        titleLabel = UILabel()
        titleLabel.text = "CURent"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .light)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        sloganLabel = UILabel()
        sloganLabel.lineBreakMode = .byWordWrapping
        sloganLabel.numberOfLines = 3
        sloganLabel.text = "Peer-to-peer subleasing platform for Cornellians"
        sloganLabel.textColor = .white
        sloganLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sloganLabel)
        
        signInButton = GIDSignInButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(signInButton)
        
        setUpConstraints()
        
        //initialize sign-in
        GIDSignIn.sharedInstance().clientID = "1038870228728-bbqpbhvmt6bf3vo4pkf4us1i9d3b9sch.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            navigationController?.pushViewController(BrowserViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
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

