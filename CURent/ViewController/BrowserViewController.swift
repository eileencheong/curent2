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

protocol SaveButtonDelegate {
    func saveButtonPressed(withName propertyAdd: Property)
}

class BrowserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SaveButtonDelegate {
    
    let property0: Property = Property(propertyName: "Property 0", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: 1000, propertyLocation: .collegetown, propertyAddress: "Sample Address", propertyDescription: "This is a description.", ownerName: "Sample First Name", propertyLatitude: 100.00, propertyLongitude: 100.00)
    let property1: Property = Property(propertyName: "idkthename", propertyImage: #imageLiteral(resourceName: "p2"), propertyPrice: 240, propertyLocation: .collegetown, propertyAddress: "idk", propertyDescription: "desca;lskdfn", ownerName: "umme?", propertyLatitude: 122.0, propertyLongitude: 133.0)

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
    
    var filterLabel: UILabel!
    var propertyBrowserLabel: UILabel!
    
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
        welcomeLabel.text = "Hi, \(userGivenName ?? "")!"
        welcomeLabel.textColor = UIColor.black
        welcomeLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
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
        
        //SECTION: Filter Label
        filterLabel = UILabel()
        filterLabel.text = "I'M LOOKING FOR..."
        filterLabel.textColor = UIColor.lightGray
        filterLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterLabel)
        
        //SECTION: Property Browser Label
        propertyBrowserLabel = UILabel()
        propertyBrowserLabel.text = "MATCHING PROPERTIES"
        propertyBrowserLabel.textColor = UIColor.lightGray
        propertyBrowserLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        propertyBrowserLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyBrowserLabel)
        
        setUpConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints() {
        //TODO: STUB

        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28)
            ])
        
        NSLayoutConstraint.activate([
            propertyCollectionView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            propertyCollectionView.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            propertyCollectionView.topAnchor.constraint(equalTo: propertyBrowserLabel.bottomAnchor, constant: 18),
            propertyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            filterCollectionView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 18),
            filterCollectionView.heightAnchor.constraint(equalToConstant: filterCollectionViewHeight)
            ])
        
        NSLayoutConstraint.activate([
            propertyBrowserLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            propertyBrowserLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            propertyBrowserLabel.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 28)
            ])
        
        NSLayoutConstraint.activate([
            filterLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            filterLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32)
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
            cell.propertyPriceLabel.text = property.priceSymbol()
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
            guard collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) is FilterCollectionViewCell else { return }
            let currentFilter = filters[indexPath.item]
            changeFilter(filter: currentFilter, shouldRemove: false)
            propertyCollectionView.reloadData()
        }
    }
    
    //remove filter
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            guard collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) is FilterCollectionViewCell else { return }
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
        vc.delegate = self
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
        
        filterProperties() //now filter the Properties according to our activeFilters
    }
    
    func filterProperties() {
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
    func saveButtonPressed(withName propertyAdd: Property) {
        sampleProperties.append(propertyAdd)
        print(sampleProperties)
        propertyCollectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        //collectionView.deselectItem(at: indexPath, animated: true)
        if (collectionView == propertyCollectionView) {
            let detailVC = PropertyDetailViewController()
            let propertyHere: Property
            propertyHere = activeProperties[indexPath.item]
            detailVC.propertyH = propertyHere
//        detailVC.latitude = propertyHere.propertyLatitude
//        detailVC.longitude = propertyHere.propertyLongitude
//        detailVC.propertyNameLabel.text = propertyHere.propertyName
//        detailVC.propertyPriceLabel.text = "\(propertyHere.propertyPrice)"
//        detailVC.propertyDescriptionLabel.text = propertyHere.propertyDescription
//        detailVC.propertyImageView.image = propertyHere.propertyImage
            let nav = UINavigationController(rootViewController: detailVC)
            present(nav, animated: true, completion: nil)
        }

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
