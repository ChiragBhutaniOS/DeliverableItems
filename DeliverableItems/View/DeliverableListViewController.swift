//
//  ViewController.swift
//  DeliverableItems
//
//  Created by Chirag Bhutani on 06/11/19.
//  Copyright © 2019 Chirag Bhutani. All rights reserved.
//

import UIKit

class DeliverableListViewController: UITableViewController {
 
    let cellId = "deliverableCell"
//    var deliverables : [Deliverable] = []
    let deliverableListViewModel = DeliverableListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(DeliverableCell.self, forCellReuseIdentifier: cellId)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return deliverableListViewModel.deliverables.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentItem = deliverableListViewModel.deliverables.value[indexPath.row]
        cell.textLabel?.text = currentItem.description
        return cell
    }
    
    private func setUpObservers() {
        
        deliverableListViewModel.deliverables.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }

    
    }

}
