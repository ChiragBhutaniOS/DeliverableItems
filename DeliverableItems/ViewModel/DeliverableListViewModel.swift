//
//  DeliverableListViewModel.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import Foundation
import CoreData
import Alamofire


class GenericDataSource<T> : NSObject {
    var deliverables: DynamicValue<[T]> = DynamicValue([])
}

class DeliverableListViewModel : GenericDataSource<Deliverable> {

    var dataFactory: DeliverableDataFactory  = DeliverableDataFactory()

    var onDataUpdate: (() -> Void)?

    //Use Fetch Controller to fetch data
    //let  fetchController: NSFetchedResultsController

    override init() {
        self.dataFactory.loadDeliverableData()
    }

    func numberOfRows () -> Int {
        return deliverables.value.count
    }


    func descriptionForRow (_ row: Int) -> String {
        let deliverable = deliverables.value[row]
        return deliverable.description ?? ""
    }

    func imageUrlForRow(_ row: Int) -> String {
        let deliverable = deliverables.value[row]
        return deliverable.imageUrl ?? ""
    }

    func refresh() {

        dataFactory.loadDeliverableData()
    }
}

//protocol DeliverableListViewModel {
//
//    var deliverables: [ Deliverable] { get }
//
//    var dataFactory: DeliverableDataFactory { get }
//
//    var onDataUpdate: (() -> Void)? { get  }
//
//    //Use Fetch Controller to fetch data
//    //let  fetchController: NSFetchedResultsController
//
//    init()
//
//    func numberOfRows () -> Int
//
//    func descriptionForRow (_ row: Int)
//
//    func imageUrlForRow(_ row: Int)
//
//    func refresh()
//}
//
//extension DeliverableListViewModelValue: DeliverableListViewModel {
//
//}

class DeliverableDataFactory: NSObject {
    
    let apiBaseUrl: String = "https://mock-api-mobile.dev.lalamove.com/deliveries"
    
    
    //Implement Paging Logic Here
    
    func loadDeliverableData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let deliverableEntity = NSEntityDescription.entity(forEntityName: "DeliveryItem", in: context)
        
        let url = URL.init(string: apiBaseUrl)
        let parameters = ["offset": 0, "limit": 20]
        
         //Load Deliverable data
//        Alamofire.request(url!, method: .get, parameters: parameters, encoding: Alamofire.JSONEncoding.default)
//            .responseJSON { response in
//                debugPrint(response)
//                    if let data = response.result.value{
//                    // Response type-1
//                    if  (data as? [[String : AnyObject]]) != nil{
//
//
//                        print("data_1: \(data)")
//
//                    }
//                    // Response type-2
//                    if  (data as? [String : AnyObject]) != nil{
//                        print("data_2: \(data)")
//                    }
                }
}

