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

class PropertyDetailViewController: UIViewController, GMSAutocompleteViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup autocompleteViewController
        let autocompleteViewController = GMSAutocompleteViewController()
        autocompleteViewController.delegate = self




        setUpConstraints()

        // Do any additional setup after loading the view.
    }

    func setUpConstraints() {

    }

    func openAutocompleteViewController() {
        self.present(autocompleteViewController, animated: true,  completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        <#code#>
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
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
