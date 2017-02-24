//
//  EntriesTableViewController.swift
//  TableView
//
//  Created by User on 1/23/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    var entries = [Entry]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private let manager = EntryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entries = manager.getAllEntries()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell

        cell.entry = entries[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, identifier == "showEntry" else {
            return
        }
        
        guard let cell = sender as? EntryTableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        if let destinationVC = segue.destination as? SingleEntryTableViewController {
            destinationVC.entry = entries[indexPath.row]
        }
    }
}
