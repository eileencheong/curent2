//
//  AddPropertyViewController.swift
//  CURent
//
//  Created by Jaewon Sim on 4/29/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SnapKit
import ChameleonFramework

class AddPropertyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

    var propertyNameField: UITextField!
    var propertyImageView: UIImageView!
    
    var propertyImageChangeButton: UIButton!
    
    let propertyImagePicker = UIImagePickerController()
    
    var propertyPriceField: UITextField!
    var propertyAddressField: UITextField!
    var propertyDescriptionView: UITextView!
    
    let autocompleteViewController = GMSAutocompleteViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        propertyImagePicker.delegate = self
        
        title = "Add Property"
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveProperty))
        
       
        autocompleteViewController.delegate = self

        propertyImageView = UIImageView()
        propertyImageView.clipsToBounds = true
        propertyImageView.layer.cornerRadius = 10
        propertyImageView.translatesAutoresizingMaskIntoConstraints = false
        propertyImageView.image = #imageLiteral(resourceName: "placeholder_img")
        propertyImageView.contentMode = .scaleAspectFill
        view.addSubview(propertyImageView)
        
        propertyImageChangeButton = UIButton()
        propertyImageChangeButton.setTitle("Change image", for: .normal)
        propertyImageChangeButton.setTitleColor(.gray, for: .normal)
        propertyImageChangeButton.addTarget(self, action: #selector(photoFromLibrary(_sender:)), for: .touchUpInside)
        propertyImageChangeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        propertyImageChangeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyImageChangeButton)
        
        
        propertyNameField = UITextField()
        propertyNameField.borderStyle = .roundedRect
        propertyNameField.font = UIFont.systemFont(ofSize: 13)
        propertyNameField.placeholder = "Property name"
        propertyNameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyNameField)
        
        propertyPriceField = UITextField()
        propertyPriceField.borderStyle = .roundedRect
        propertyPriceField.font = UIFont.systemFont(ofSize: 13)
        propertyPriceField.placeholder = "Price"
        propertyPriceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyPriceField)
        
        propertyAddressField = UITextField()
        propertyAddressField.borderStyle = .roundedRect
        propertyAddressField.font = UIFont.systemFont(ofSize: 13)
        propertyAddressField.placeholder = "Address"
        propertyAddressField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidBegin)
        propertyAddressField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyAddressField)
        
        propertyDescriptionView = UITextView()
        propertyDescriptionView.text = "Description"
        propertyDescriptionView.font = UIFont.systemFont(ofSize: 13)
        propertyDescriptionView.layer.borderWidth = 1.0
        propertyDescriptionView.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        propertyDescriptionView.textColor = UIColor(red: 214/255, green: 214/255, blue: 217/255, alpha: 1.0)
        propertyDescriptionView.layer.cornerRadius = 5.0
        propertyDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(propertyDescriptionView)

        setUpConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            propertyImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            propertyImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            propertyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            propertyImageView.bottomAnchor.constraint(equalTo: propertyImageView.topAnchor, constant: 200)
            ])
        
        NSLayoutConstraint.activate([
            propertyImageChangeButton.leadingAnchor.constraint(equalTo: propertyImageView.leadingAnchor, constant: 24),
            propertyImageChangeButton.trailingAnchor.constraint(equalTo: propertyImageView.trailingAnchor, constant: -24),
            propertyImageChangeButton.topAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: -24),
            propertyImageChangeButton.bottomAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            propertyNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            propertyNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            propertyNameField.topAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: 24)
            ])
        
        NSLayoutConstraint.activate([
            propertyPriceField.leadingAnchor.constraint(equalTo: propertyNameField.leadingAnchor),
            propertyPriceField.trailingAnchor.constraint(equalTo: propertyNameField.trailingAnchor),
            propertyPriceField.topAnchor.constraint(equalTo: propertyNameField.bottomAnchor, constant: 18)
            ])
        
        NSLayoutConstraint.activate([
            propertyAddressField.leadingAnchor.constraint(equalTo: propertyNameField.leadingAnchor),
            propertyAddressField.trailingAnchor.constraint(equalTo: propertyNameField.trailingAnchor),
            propertyAddressField.topAnchor.constraint(equalTo: propertyPriceField.bottomAnchor, constant: 18)
            ])
        
        NSLayoutConstraint.activate([
            propertyDescriptionView.leadingAnchor.constraint(equalTo: propertyNameField.leadingAnchor),
            propertyDescriptionView.trailingAnchor.constraint(equalTo: propertyNameField.trailingAnchor),
            propertyDescriptionView.topAnchor.constraint(equalTo: propertyAddressField.bottomAnchor, constant: 18),
            propertyDescriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
            ])
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        present(autocompleteViewController, animated: true,  completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        propertyAddressField.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        let autocompleteErrorAlert = UIAlertController(title: "Error", message: "An error occurred while autocompleting your address. Please try again.", preferredStyle: .alert)
        autocompleteErrorAlert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: { action in
            autocompleteErrorAlert.dismiss(animated: true, completion: nil)
        }))
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func photoFromLibrary(_sender: UIButton) {
        propertyImagePicker.sourceType = .photoLibrary
        propertyImagePicker.allowsEditing = false
        present(propertyImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        propertyImageView.contentMode = .scaleAspectFill
        propertyImageView.image = chosenImage
        propertyImageChangeButton.setTitleColor(ContrastColorOf(AverageColorFromImage(chosenImage), returnFlat: true), for: .normal) //need to make the color refresh!
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveProperty() {
        
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
