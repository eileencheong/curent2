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
//    returnArray.append(property1)
//    returnArray.append(property2)
//    returnArray.append(property3)
//    returnArray.append(property4)
//    returnArray.append(property5)
//    returnArray.append(property6)
//    returnArray.append(property7)
    return returnArray
}

let property0: Property = Property(propertyName: "Property 0", propertyImage: #imageLiteral(resourceName: "p0"), propertyPrice: 1000, propertyLocation: .collegetown, propertyAddress: "Sample Address", propertyDescription: "This is a description.", ownerFirstName: "Sample First Name")
