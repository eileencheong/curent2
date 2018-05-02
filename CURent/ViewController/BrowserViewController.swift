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
    var activeProperties: [Property] = []
    
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
        activeProperties = sampleProperties
        filters.append(contentsOf: PropertyPrice.allValues().map({ f in f as Filter}))
        filters.append(contentsOf: PropertyLocation.allValues().map({ f in f as Filter}))
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.allowsMultipleSelection = true
        view.addSubview(filterCollectionView)
        
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
            propertyCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 12),
            propertyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            filterCollectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            filterCollectionView.heightAnchor.constraint(equalToConstant: filterCollectionViewHeight)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            let filter = filters[indexPath.item]
            cell.setup(with: filter.filterTitle)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: propertyCollectionViewCellReuseIdentifier, for: indexPath) as? PropertyCollectionViewCell else { return UICollectionViewCell() }
            let property = activeProperties[indexPath.item]
            cell.propertyImageView.image = property.propertyImage
            cell.propertyNameLabel.text = property.propertyName
            cell.propertyLocationLabel.text = property.propertyLocation.filterTitle
            cell.propertyPriceLabel.text = propertyPriceToSymbol(price: property.propertyPrice).filterTitle
            cell.setNeedsUpdateConstraints()
            return cell
        }
    }
    
    
    func collectionView(_ CollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (CollectionView == propertyCollectionView) {
            return activeProperties.count
        }
        else {
            return filters.count
            //TODO: STUB
        }
    }
    
    //add filter
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
            let currentFilter = filters[indexPath.item]
            changeFilter(filter: currentFilter, shouldRemove: false)
            propertyCollectionView.reloadData()
        }
    }
    
    //remove filter
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
            let currentFilter = filters[indexPath.item]
            changeFilter(filter: currentFilter, shouldRemove: true)
            propertyCollectionView.reloadData()
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
    
    func changeFilter(filter: Filter, shouldRemove: Bool = false) {
        if let propertyPrice = filter as? PropertyPrice {
            if shouldRemove {
                activeCostFilter.remove(propertyPrice)
            } else {
                activeCostFilter.insert(propertyPrice)
            }
        }
        if let propertyLocation = filter as? PropertyLocation {
            if shouldRemove {
                activePlaceFilter.remove(propertyLocation)
            } else {
                activePlaceFilter.insert(propertyLocation)
            }
        }
        
        filterRestaurants() //now filter the restaurants according to our activeFilters
    }
    
    func filterRestaurants() {
        if activePlaceFilter.count == 0 && activeCostFilter.count == 0 {
            activeProperties = sampleProperties
            return
        }
        activeProperties = sampleProperties.filter({ r in
            var placeFilteredOut = activePlaceFilter.count > 0
            if activePlaceFilter.count > 0 {
                if activePlaceFilter.contains(r.propertyLocation) {
                    placeFilteredOut = false
                }
            }
            
            var costFilteredOut = activeCostFilter.count > 0
            if activeCostFilter.count > 0 {
                if activeCostFilter.contains(propertyPriceToSymbol(price: r.propertyPrice)) {
                    costFilteredOut = false
                }
            }
            
            return !(placeFilteredOut || costFilteredOut)
        })
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
