//
//  Geocode.swift
//  CURent
//
//  Created by Jaewon Sim on 5/1/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Geocode {
    private static let endpoint = "https://maps.googleapis.com/maps/api/geocode/json"
    private static let key = "AIzaSyDbAj9YaE9T-QeCj7Q2gqTm2Nz4O-TUQ08"
    
    static func geocode(withQuery query: String, _ completion: @escaping ([Recipe]) -> Void) {
        
    }
    
}
