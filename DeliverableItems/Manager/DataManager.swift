//
//  DataManager.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import UIKit

protocol DataManagerProtocol: class {
    func fetchDeliveries(offset: Int, limit: Int, completion: @escaping ([Deliverable]?, Error?) -> Void)
    func fetchDeliveriesForPullToRefresh(offset: Int, limit: Int, completion: @escaping ([Deliverable]?, Error?) -> Void)
}

class DataManager: NSObject, DataManagerProtocol {
    var coreDataManager: CoreDataManagerProtocol = CoreDataManager.sharedInstance
    var deliveryService: DeliveryServiceProtocol =  DeliveryService.shared
    
    func fetchDeliveries(offset: Int, limit: Int, completion: @escaping ([Deliverable]?, Error?) -> Void) {
        //Check if data in CoreData
        let deliveryProductsFromCoreData = coreDataManager.fetchDeliveries(offset: offset, limit: limit)
        
        if let deliveryProducts = deliveryProductsFromCoreData, !deliveryProducts.isEmpty {
            let deliveryItems = convertDeliveryProducts(deliveryProducts: deliveryProducts)
            completion(deliveryItems, nil)
        } else {
            // Get Data from API
            deliveryService.fetchDeliveries(offset: offset, limit: limit) { [weak self] result in
                
                switch result {
                case .success(let deliveryItems):
                    completion(deliveryItems, nil)
                    self?.insertDeliveryItems(deliveryItems: deliveryItems)
                    
                case .failure(let error):
                    debugPrint(error)
                    completion(nil, error)                    
                }
            }
        }
    }
    
    func fetchDeliveriesForPullToRefresh(offset: Int, limit: Int, completion: @escaping ([Deliverable]?, Error?) -> Void) {
        // Get Data from API
        deliveryService.fetchDeliveries(offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let deliveryItems):
                if !deliveryItems.isEmpty {
                    completion(deliveryItems, nil)
                    self?.coreDataManager.deleteAllItems()
                    self?.insertDeliveryItems(deliveryItems: deliveryItems)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }    
}

// MARK: Helper Methods
extension DataManager {
    
    func insertDeliveryItems(deliveryItems: [Deliverable]) {
        for item in deliveryItems {
            _ = coreDataManager.insert(deliverable: item)
        }
    }
    
    func convertDeliveryProducts(deliveryProducts: [DeliveryProduct]) -> [Deliverable] {
        let deliveryItems: [Deliverable] = deliveryProducts.map { convertDeliveryProductIntoDeliveryItem(deliveryProduct: $0)}
        return deliveryItems
    }
    
    func convertDeliveryProductIntoDeliveryItem(deliveryProduct: DeliveryProduct) -> Deliverable {
        
        let deliveryLocation = DeliverableLocation(lat: deliveryProduct.lat,
                                                lng: deliveryProduct.lng,
                                                address: deliveryProduct.address ?? "")
        let deliveryItem = Deliverable(id: Int(deliveryProduct.id),
                                        description: deliveryProduct.itemDescription ?? "",
                                        imageUrl: deliveryProduct.imageUrl ?? "",
                                        location: deliveryLocation)
        return deliveryItem
    }
}
