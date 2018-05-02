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

protocol Filter {
    var filterTitle: String { get }
}

enum PropertyPrice: Filter {
    case inexpensive
    case midrange
    case expensive
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [PropertyPrice] {
        return [.inexpensive, .midrange, .expensive]
    }
}

enum PropertyLocation: Filter {
    case collegetown
    case downtown
    case westCampus
    case northCampus
    case other
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [PropertyLocation] {
        return [.collegetown, .downtown, .westCampus, .northCampus, .other]
    }
    
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
    
    func priceSymbol() -> String {
        if (propertyPrice) <= 300 {
            return "$"
        } else if (propertyPrice > 300 && propertyPrice <= 600) {
            return "$$"
        } else {
            return "$$$"
        }
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



