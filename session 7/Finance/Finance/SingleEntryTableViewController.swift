//
//  SingleEntryTableViewController.swift
//  TableView
//
//  Created by User on 1/23/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class SingleEntryTableViewController: UITableViewController {
    
    enum CellsPath {
        case Details
        
        var indexPath: IndexPath {
            switch self {
            case .Details:
                return IndexPath(row: 0, section: 1)
            }
        }
    }

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        amountLabel?.text = "$\(entry?.amount ?? 0)"
        groupLabel?.text = entry?.group?.rawValue
        detailsLabel?.text = entry?.details
        dateLabel?.text = entry?.date?.toString()
        
        if let imageName = entry?.group?.rawValue.lowercased() {
            icon?.image = UIImage(named: imageName)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath == CellsPath.Details.indexPath {
            performSegue(withIdentifier: "showDetails", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, identifier == "showDetails" else {
            return
        }

        if let destinationVC = segue.destination as? TextViewController {
                destinationVC.text = entry?.details
            }
    }
}


