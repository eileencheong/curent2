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


class Property {
    var propertyName: String
    var propertyImage: UIImage
    var propertyPrice: Double
    var propertyLocation: PropertyLocation
    var propertyAddress: String
    var propertyDescription: String
    
    var ownerName: String
    
    init(propertyName: String, propertyImage: UIImage, propertyPrice: Double, propertyLocation: PropertyLocation, propertyAddress: String, propertyDescription: String, ownerName: String) {
        self.propertyName = propertyName
        self.propertyImage = propertyImage
        self.propertyPrice = propertyPrice
        self.propertyLocation = propertyLocation
        self.propertyAddress = propertyAddress
        self.propertyDescription = propertyDescription
        self.ownerName = ownerName
    }
    
    
    
}

func propertyPriceToSymbol(price: Double) -> PropertyPrice {
    if (price <= 300) {
        return .inexpensive
    } else if (price > 300 && price <= 600) {
        return .midrange
    } else {
        return .expensive
    }
    
}

