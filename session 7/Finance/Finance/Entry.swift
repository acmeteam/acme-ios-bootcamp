//
//  Entry.swift
//  Finance
//
//  Created by Petar Cvijic on 1/23/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import Foundation
import UIKit

enum Group: String {
    case Transportation
    case Food
    case Sport
    case Toys
    case Health
    case Gift
    case Cloth
    case Fuel
    case Tech
    case Music
    case Party
    
    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage(named: "defaultImage")!
    }
}

struct Entry {
    let details: String?
    let amount: Float?
    let date: Date?
    let group: Group?
}
