//
//  Utility.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 08/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation

class Utility: NSObject {
    
    static let sharedInstance = Utility()
    
    private override init() {}
    
    func checkValidUrl(urlStr: String) -> Bool {
        guard URL(string: urlStr) != nil else {
            return false
        }
        return true
    }
    
}
