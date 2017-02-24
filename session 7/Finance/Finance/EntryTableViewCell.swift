//
//  EntryTableViewCell.swift
//  TableView
//
//  Created by User on 1/23/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            configureCell()
            print("Config - table cell")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("New - table cell")
    }
    
    private func configureCell() {
        amountLabel?.text = "$\(entry?.amount ?? 0)"
        groupLabel?.text = entry?.group?.rawValue
        
        if let imageName = entry?.group?.rawValue.lowercased() {
            icon?.image = UIImage(named: imageName)
        }
    }
}
