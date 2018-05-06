//
//  PropertyDetailViewController.swift
//  CURent
//
//  Created by Jaewon Sim on 4/28/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PropertyDetailViewController: UIViewController {

//    var propertyName: String = "Name"
//    var propertyAddress: String = "Address, Address"
//    var propertyPrice: String = "10000.00"
//    var propertyDescription: String = "This is a sample description."
    
    var propertyNameLabel: UILabel!
    var propertyImageView: UIImageView!
    var propertyPriceLabel: UILabel!
    var propertyAddressLabel: UILabel!
    var openMapButton: UIButton!
    var propertyDescriptionLabel: UILabel!
    var propertyH : Property?

    var latitude: Double = 100.0
    var longitude: Double = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = propertyH?.propertyName
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeView))
        
        latitude = (propertyH?.propertyLatitude)!
        longitude = (propertyH?.propertyLongitude)!
        
        propertyNameLabel = UILabel()
        propertyNameLabel.text = propertyH?.propertyName
        propertyNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        propertyNameLabel.textColor = .gray
        propertyNameLabel.textAlignment = .center
        propertyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyNameLabel)
        
        propertyAddressLabel = UILabel()
        propertyAddressLabel.text = propertyH?.propertyAddress
        propertyAddressLabel.font = UIFont.boldSystemFont(ofSize: 12)
        propertyAddressLabel.textColor = UIColor.lightGray
        propertyAddressLabel.textAlignment = .center
        propertyAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyAddressLabel)
        
        propertyImageView = UIImageView()
        propertyImageView.image = propertyH?.propertyImage
        propertyImageView.layer.cornerRadius = 10
        propertyImageView.clipsToBounds = true
        propertyImageView.contentMode = .scaleAspectFill
        propertyImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyImageView)
        
        propertyPriceLabel = UILabel()
        propertyPriceLabel.text = propertyH?.priceSymbol()
        propertyPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        propertyPriceLabel.textColor = UIColor.lightGray
        propertyPriceLabel.textAlignment = .center
        propertyPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyPriceLabel)
        
        propertyDescriptionLabel = UILabel()
        propertyDescriptionLabel.text = propertyH?.propertyDescription
        propertyDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        propertyDescriptionLabel.textColor = UIColor.lightGray
        propertyDescriptionLabel.lineBreakMode = .byWordWrapping
        propertyDescriptionLabel.numberOfLines = 10
        propertyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyDescriptionLabel)
        
        
        openMapButton = UIButton()
        openMapButton.addTarget(self, action: #selector(openMapView(controller:)), for: .touchUpInside)
        openMapButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(openMapButton)
        
        
        
        setUpConstraints()

        // Do any additional setup after loading the view.
    }

    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            propertyNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            propertyNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            propertyNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
            ])
        
        NSLayoutConstraint.activate([
            propertyAddressLabel.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            propertyAddressLabel.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            propertyAddressLabel.topAnchor.constraint(equalTo: propertyNameLabel.bottomAnchor, constant: 12)
            ])
        
        NSLayoutConstraint.activate([
            openMapButton.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            openMapButton.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            openMapButton.topAnchor.constraint(equalTo: propertyAddressLabel.bottomAnchor, constant: 12)
            ])
        
        NSLayoutConstraint.activate([
            propertyImageView.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            propertyImageView.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            propertyImageView.topAnchor.constraint(equalTo: openMapButton.bottomAnchor, constant: 24),
            propertyImageView.bottomAnchor.constraint(equalTo: propertyImageView.topAnchor, constant: 200)
            ])
        

        NSLayoutConstraint.activate([
            propertyPriceLabel.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            propertyPriceLabel.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            propertyPriceLabel.topAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: 18)
            ])
        
        NSLayoutConstraint.activate([
            propertyDescriptionLabel.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            propertyDescriptionLabel.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            propertyDescriptionLabel.topAnchor.constraint(equalTo: propertyPriceLabel.bottomAnchor, constant: 18),
            propertyDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
            ])
    }
    
    @objc func openMapView(controller: UIViewController) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let vc = UIViewController()
        vc.view = mapView
        let nav = UINavigationController(rootViewController: vc)
        controller.present(nav, animated: true, completion: nil)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
