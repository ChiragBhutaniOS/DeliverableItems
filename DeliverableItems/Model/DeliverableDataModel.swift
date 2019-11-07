//
//  DeliverableDataModel.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation

struct Deliverable{
    let id : Int?
    let description: String?
    let imageUrl: String?
    let location: [String: Any]?
}

//extension Deliverable {
//    enum CodingKeys: String, CodingKey {
//        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
//        case id
//        case description
//        case imageUrl
//        case location
//    }
//}
