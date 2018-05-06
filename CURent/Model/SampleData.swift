//
//  SampleData.swift
//  CURent
//
//  Created by Jaewon Sim on 4/28/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import Foundation

func createInitialPropertyArray() -> [Property] {
    var returnArray: [Property] = []
    returnArray.append(property0)
    returnArray.append(property0)
    returnArray.append(property0)
    returnArray.append(property1)
    returnArray.append(property2)
    returnArray.append(property3)
    returnArray.append(property4)
//    returnArray.append(property0)
//    returnArray.append(property2)
//    returnArray.append(property3)
//    returnArray.append(property4)
//    returnArray.append(property5)
//    returnArray.append(property6)
//    returnArray.append(property7)
    return returnArray
}

let property0: Property = Property(propertyName: "312 College Avenue", propertyImage: #imageLiteral(resourceName: "312college"), propertyPrice: 1000, propertyLocation: .collegetown, propertyAddress: "312 College Avenue, Ithaca NY", propertyDescription: "Experience intelligent design and smart living at 312 College Avenue in a furnished studio, 1, 2, or 3 bedroom apartment in the heart of Collegetown, Ithaca, New York. Convenient and efficient services such as recurring rental payments, dry cleaning pickup and drop off, and package delivery to complement your busy lifestyle. Enjoy our amenities from fitness center to library, all within our building and a short walk to the Cornell Campus. Secure well lit parking under the building.", ownerName: "John Doe", propertyLatitude: 100.00, propertyLongitude: 100.00)
let property1: Property = Property(propertyName: "Sample Property A", propertyImage: #imageLiteral(resourceName: "p2"), propertyPrice: 240, propertyLocation: .downtown, propertyAddress: "312 College Avenue", propertyDescription: "This is a description.", ownerName: "John Doe", propertyLatitude: 122.0, propertyLongitude: 133.0)
let property2: Property = Property(propertyName: "Sample Property B", propertyImage: #imageLiteral(resourceName: "p2"), propertyPrice: 240, propertyLocation: .northCampus, propertyAddress: "312 College Avenue", propertyDescription: "This is a description.", ownerName: "John Doe", propertyLatitude: 122.0, propertyLongitude: 133.0)
let property3: Property = Property(propertyName: "Sample Property C", propertyImage: #imageLiteral(resourceName: "p2"), propertyPrice: 240, propertyLocation: .other, propertyAddress: "312 College Avenue", propertyDescription: "This is a description.", ownerName: "John Doe", propertyLatitude: 122.0, propertyLongitude: 133.0)
let property4: Property = Property(propertyName: "Sample Property D", propertyImage: #imageLiteral(resourceName: "p2"), propertyPrice: 240, propertyLocation: .collegetown, propertyAddress: "312 College Avenue", propertyDescription: "This is a description.", ownerName: "John Doe", propertyLatitude: 122.0, propertyLongitude: 133.0)
