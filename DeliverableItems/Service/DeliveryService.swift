//
//  DeliveryService.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation

protocol DeliveryServiceProtocol: class {
    func fetchDeliveries(offset: Int, limit: Int, _ completion: @escaping ((Result<[Deliverable], Error>) -> Void))
}

final class DeliveryService: DeliveryServiceProtocol {
    
    static let shared = DeliveryService()
    let endpoint : String = "https://mock-api-mobile.dev.lalamove.com/deliveries"
    
    func fetchDeliveries(offset: Int, limit: Int, _ completion: @escaping (Result<[Deliverable], Error>) -> Void) {
        let url = URL(string: endpoint)!
        let finalURL = url.appending("offset", value: String(offset)).appending("limit", value: String(limit))
        if Utility.sharedInstance.checkValidUrl(urlStr: finalURL.absoluteString) {
            self.requestWithURL(urlStr: finalURL.absoluteString) { result in
                completion(result)
            }
        } 
    }
    
    func requestWithURL(urlStr: String, type: RequestType = .get, completion: @escaping (Result<[Deliverable], Error>) -> Void) {
        
        let url = URL(string: urlStr)!
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = apiTimeOutInterval
        let jsonDecoder = JSONDecoder()
        
        _ =  ServiceManager.sharedInstance.performRequest(request: urlRequest, decoder: jsonDecoder, completion: completion)
    }
}
