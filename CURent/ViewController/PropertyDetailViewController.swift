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

    var latitude: Double = 100.00
    var longitude: Double = 100.00
    
    var propertyNameLabel: UILabel!
    var propertyImageView: UIImageView!
    var propertyPriceLabel: UILabel!
    var propertyAddressLabel: UILabel!
    var openMapButton: UIButton!
    var propertyDescription: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertyNameLabel = UILabel()
        
        propertyImageView = UIImageView()
        
        propertyPriceLabel = UILabel()
        
        propertyAddressLabel = UILabel()
        
        openMapButton = UIButton()
        //openMapButton.addTarget(self, action: #selector(openMapView(controller:)), for: <#T##UIControlEvents#>)
        
        propertyDescription = UILabel()
        
        //map setup
        
        
        
        
        
        setUpConstraints()

        // Do any additional setup after loading the view.
    }

    func setUpConstraints() {

    }
    
    @objc func openMapView(controller: UIViewController) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let vc = UIViewController()
        vc.view = mapView
        let nav = UINavigationController(rootViewController: vc)
        controller.present(nav, animated: true, completion: nil)
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
