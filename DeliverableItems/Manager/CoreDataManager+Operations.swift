//
//  CoreDataManager+Operations.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func insert(deliverable: Deliverable) -> DeliveryProduct?
    func deleteAllItems()
    func fetchDeliveries(offset: Int, limit: Int) -> [DeliveryProduct]?
}

extension CoreDataManager: CoreDataManagerProtocol {
    
    func insert(deliverable: Deliverable) -> DeliveryProduct? {
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DeliveryProduct", in: managedContext)!
        let deliveryProduct = NSManagedObject(entity: entity, insertInto: managedContext) as? DeliveryProduct
        
        deliveryProduct?.id = Int16(deliverable.id ?? 0)
        deliveryProduct?.imageUrl = deliverable.imageUrl
        deliveryProduct?.itemDescription = deliverable.description
        deliveryProduct?.address = deliverable.location?.address
        deliveryProduct?.lat = deliverable.location?.lat ?? 0.0
        deliveryProduct?.lng = deliverable.location?.lng ?? 0.0
        
        do {
            try managedContext.save()
            return deliveryProduct
        } catch let error as NSError {
            debugPrint("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteAllItems() {
        
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeliveryProduct")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
        } catch {
            debugPrint("There is an error in deleting records")
        }
    }
    
    func fetchDeliveries(offset: Int, limit: Int) -> [DeliveryProduct]? {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeliveryProduct")
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        do {
            let deliveryProducts = try managedContext.fetch(fetchRequest)
            return deliveryProducts as? [DeliveryProduct]
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}
