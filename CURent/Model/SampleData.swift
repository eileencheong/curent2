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
    returnArray.append(property1)
    returnArray.append(property2)
    returnArray.append(property3)
    returnArray.append(property4)
    returnArray.append(property5)
    returnArray.append(property6)
    returnArray.append(property7)
    return returnArray
}

let property0: Property = Property(propertyName: "Property 0", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property1: Property = Property(propertyName: "Property 1", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property2: Property = Property(propertyName: "Property 2", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property3: Property = Property(propertyName: "Property 3", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property4: Property = Property(propertyName: "Property 4", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property5: Property = Property(propertyName: "Property 5", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property6: Property = Property(propertyName: "Property 6", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)

let property7: Property = Property(propertyName: "Property 7", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: .expensive, propertyLocation: .collegetown, propertyAddress: "Sample Address", ownerFirstName: "Sample First Name", userIsVerified: true)
