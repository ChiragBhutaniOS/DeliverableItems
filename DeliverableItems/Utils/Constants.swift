//
//  Constants.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 08/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation
import UIKit

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

let cornerRadius: CGFloat = 5.0
let noDataLabelWidthConstant: CGFloat = 300

struct CellImageParameters {
    private init() {}
    static let height = 50
    static let width = 50
}

struct TableParameters {
    private init() {}
    static let estimatedHeight = 50
    static let footerHeight = 50
}

struct DetailViewParameters {
    private init() {}
    static let imageHeight = 80
    static let imageWidth = 80
    static let detailViewBottomConstant = 40
    static let detailViewHeightConstant = 100
}

struct ApplicationFont {
    private init() {}
    static let avenirNextDemiBold = UIFont(name: "AvenirNext-DemiBold", size: 16)
    static let systemBold = UIFont.boldSystemFont(ofSize: 20)
}

struct APIEndPoint {
    private init() {}
    static let baseUrl = "https://mock-api-mobile.dev.lalamove.com/"
    static let deliveryService = "deliveries"
}

let  apiTimeOutInterval: TimeInterval = 60
let fetchLimit = 20
