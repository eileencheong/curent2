//
//  BrowserViewController.swift
//  CURent
//
//  Created by Jaewon Sim on 4/26/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import UIKit
import GoogleSignIn
import ChameleonFramework

class BrowserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //SECTION: Preparing GIDUser attributes
    var welcomeLabel: UILabel!
    //var userImageView: UIImageView!
    let userGivenName = GIDSignIn.sharedInstance().currentUser.profile.givenName
    //let userImageURL = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 14)
    
    var filterCollectionViewHeight: CGFloat = 50
    
    var sampleProperties: [Property] = []
    var activeRestaurants: [Property] = []
    
    var filters: [Filter] = []
    var activeCostFilter: Set<PropertyPrice> = []
    var activePlaceFilter: Set<PropertyLocation> = []

    var propertyCollectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    
    let propertyCollectionViewCellReuseIdentifier = "propertyCell"
    let filterReuseIdentifier: String = "FilterCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = "Browse"
        
        sampleProperties = createInitialPropertyArray()
        activeRestaurants = sampleProperties
        filters.append(contentsOf: PropertyPrice.allValues().map({ f in f as Filter}))
        filters.append(contentsOf: PropertyLocation.allValues().map({ f in f as Filter}))
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(submitListingButtonPressed))
        
        
        //SECTION: Welcome Label
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome, \(userGivenName ?? "")!"
        welcomeLabel.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        
        //SECTION: Setup propertyCollectionView
        let propertyLayout = UICollectionViewFlowLayout()
        propertyLayout.scrollDirection = .vertical
        
        propertyCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: propertyLayout)
        propertyCollectionView.backgroundColor = .white
        propertyCollectionView.dataSource = self
        propertyCollectionView.delegate = self
        propertyCollectionView.showsVerticalScrollIndicator = false
        propertyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        propertyCollectionView.register(PropertyCollectionViewCell.self, forCellWithReuseIdentifier: propertyCollectionViewCellReuseIdentifier)
        
        view.addSubview(propertyCollectionView)
        
        setUpConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints() {
        //TODO: STUB

        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18)
            ])
        
        NSLayoutConstraint.activate([
            propertyCollectionView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            propertyCollectionView.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            propertyCollectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            propertyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func collectionView(_ CollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = propertyCollectionView.dequeueReusableCell(withReuseIdentifier: propertyCollectionViewCellReuseIdentifier, for: indexPath) as! PropertyCollectionViewCell
        cell2.propertyImageView.image = sampleProperties[indexPath.item].propertyImage
        cell2.propertyNameLabel.text = sampleProperties[indexPath.item].propertyName
        cell2.propertyLocationLabel.text = sampleProperties[indexPath.item].propertyLocation.filterTitle
        cell2.propertyPriceLabel.text = propertyPriceToSymbol(price: sampleProperties[indexPath.item].propertyPrice).filterTitle
        cell2.setNeedsUpdateConstraints()
        return cell2
    }
    
    
    func collectionView(_ CollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (CollectionView == propertyCollectionView) {
            return 1
        }
        else {
            return 10
            //TODO: STUB
        }
    }
    
    func collectionView(_ CollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (CollectionView == propertyCollectionView) {
            let padding: CGFloat =  14
            let collectionViewSize = CollectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: 150)
        }
        else {
            let padding: CGFloat =  14
            let collectionViewSize = CollectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: 150)
            //TODO: STUB
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signOut() {
        let signOutAlert = UIAlertController(title: "Signing out", message: "Are you sure you want to sign out from CURent? You will need to login again with your Google credentials.", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Continue to sign out", style: .destructive, handler: { action in
            signOutAlert.dismiss(animated: true, completion: nil)
            GIDSignIn.sharedInstance().signOut()
            self.navigationController?.pushViewController(SignInViewController(), animated: true)
        }))
        signOutAlert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: { action in
            signOutAlert.dismiss(animated: true, completion: nil)
        }))
        present(signOutAlert, animated: true)
    }
    
    @objc func submitListingButtonPressed() {
        let vc = AddPropertyViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
