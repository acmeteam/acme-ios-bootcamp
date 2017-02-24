//
//  HelperExtensions.swift
//  Finance
//
//  Created by Petar Cvijic on 1/24/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.string(from: self)
    }
}

extension String {
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.date(from: self)
    }
}


