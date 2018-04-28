//
//  Property.swift
//  CURent
//
//  Created by Jaewon Sim on 4/28/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

enum PropertyPrice: String {
    case inexpensive = "$"
    case midrange = "$$"
    case expensive = "$$$"
}

enum PropertyLocation: String {
    case collegetown = "Collegetown"
    case downtown = "Downtown"
    case westCampus = "West"
    case northCampus = "North"
    case other = "Other"
}

enum VerifiedUser: String {
    case verified = "Verified"
    case unverified = "Unverified"
}

class Property {
    var propertyName: String
    var propertyImage: UIImage
    var propertyPrice: PropertyPrice
    var propertyLocation: PropertyLocation
    var propertyAddress: String
    
    var ownerFirstName: String
    var userIsVerified: Bool
    
    init(propertyName: String, propertyImage: UIImage, propertyPrice: PropertyPrice, propertyLocation: PropertyLocation, propertyAddress: String, ownerFirstName: String, userIsVerified: Bool) {
        self.propertyName = propertyName
        self.propertyImage = propertyImage
        self.propertyPrice = propertyPrice
        self.propertyLocation = propertyLocation
        self.propertyAddress = propertyAddress
        self.ownerFirstName = ownerFirstName
        self.userIsVerified = userIsVerified
    }
    
}


