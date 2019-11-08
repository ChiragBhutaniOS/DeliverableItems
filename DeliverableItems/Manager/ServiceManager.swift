//
//  ServiceManager.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import UIKit
import Alamofire

class ServiceManager: NSObject {
    
    static let sharedInstance = ServiceManager()
    
    private override init() {}
    
    func performRequest<T: Decodable>(request: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        return AF.request(request)
            .responseDecodable (decoder: decoder) { (response: AFDataResponse<T>) in
                completion(response.result)
                
                
        }
    }
}
