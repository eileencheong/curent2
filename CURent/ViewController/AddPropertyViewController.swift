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
import GoogleSignIn

class AddPropertyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

    var propertyNameField: UITextField!
    var propertyImageView: UIImageView!
    
    var propertyImageChangeButton: UIButton!
    
    let propertyImagePicker = UIImagePickerController()
    
    var propertyPriceField: UITextField!
    var propertyAddressField: UITextField!
    var propertyDescriptionView: UITextView!
    
    var propertyCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 100.00, longitude: 100.00)
    
    var delegate: SaveButtonDelegate?
    
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
        propertyDescriptionView.font = UIFont.systemFont(ofSize: 13)
        propertyDescriptionView.layer.borderWidth = 1.0
        propertyDescriptionView.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        propertyDescriptionView.textColor = .black
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
    
    private func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        present(autocompleteViewController, animated: true,  completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        propertyAddressField.text = place.formattedAddress
        propertyCoordinates = place.coordinate
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
    
    func promptIfInputEmpty() -> Bool {
        if (propertyNameField.text == "" || propertyPriceField.text == "" || propertyAddressField.text == "" || propertyDescriptionView.text == "") {
            let fieldEmptyAlert = UIAlertController(title: "Some fields are empty.", message: "Fields may not be left empty. Please go back and fill in empty fields.", preferredStyle: .alert)
            fieldEmptyAlert.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: { action in
                fieldEmptyAlert.dismiss(animated: true, completion: nil)
            }))
            present(fieldEmptyAlert, animated: true)
            return false
        } else {
            return true
        }
    }
    
    @objc func saveProperty() {
        //ACTION when Save button is pressed
        //creates a new Property object and prepares for export
        let check = promptIfInputEmpty()
        if (check) {
            var newProperty: Property
            newProperty = Property(propertyName: propertyNameField.text!, propertyImage: propertyImageView.image!, propertyPrice: Double(propertyPriceField.text!)!, propertyLocation: .collegetown, propertyAddress: propertyAddressField.text!, propertyDescription: propertyDescriptionView.text, ownerName: GIDSignIn.sharedInstance().currentUser.profile.name, propertyLatitude:propertyCoordinates.latitude, propertyLongitude: propertyCoordinates.longitude)
            delegate?.saveButtonPressed(withName: newProperty)
            
            var newPropertyJSON: [String : String] = [
                "propertyName":newProperty.propertyName,
                "propertyPrice":String(newProperty.propertyPrice),
                "propertyLocation":newProperty.propertyLocation.filterTitle,
                "propertyAddress":newProperty.propertyAddress,
                "ownerName":newProperty.ownerName,
                "propertyLatitude":String(propertyCoordinates.latitude),
                "propertyLongitude":String(propertyCoordinates.longitude)
            ]
            dismiss(animated: true, completion: nil)
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
