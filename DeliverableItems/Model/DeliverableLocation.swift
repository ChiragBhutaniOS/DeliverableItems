//
//  deliverableLocation.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 08/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation

struct DeliverableLocation: Codable {
    
    var lat: Double?
    var lng: Double?
    var address: String?
    
}

extension DeliverableLocation {
    enum CodingKeys: String, CodingKey {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case lat
        case lng
        case address
    }
}

