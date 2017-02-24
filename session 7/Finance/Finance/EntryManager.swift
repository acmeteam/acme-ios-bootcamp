//
//  EntryManager.swift
//  Finance
//
//  Created by Petar Cvijic on 1/23/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import Foundation
import UIKit

class EntryManager {
    private let bundleName = "finance-bundle"
    
    func getAllEntries() -> [Entry] {
        var fetchedEntries = [Entry]()
        
        guard let entriesAsDictArray = readBundle(from: bundleName) else {
            return fetchedEntries
        }

        
        for entryAsDict in entriesAsDictArray {
            var group: Group? = nil
            var amount: Float? = nil
            
            if let groupAsString = entryAsDict["group"] as? String {
                group = Group(rawValue: groupAsString)
            }
            
            if let amountAsString = entryAsDict["amount"] as? String {
                amount = (amountAsString as NSString).floatValue
            }
            
            let entry = Entry(details: entryAsDict["details"] as? String,
                              amount: amount,
                              date: (entryAsDict["date"] as? String)?.toDate,
                              group: group)
            
            fetchedEntries.append(entry)
        }
        
        return fetchedEntries
    }
    
    private func readBundle(from dataAssetName: String) -> [[String:Any]]?
    {
        guard let asset = NSDataAsset(name: dataAssetName)  else {
            return nil
        }
        
        guard let assetAsDictionary = convertDataToDictionary(data: asset.data) else {
            return nil
        }
        
        return  assetAsDictionary["entries"] as?  [[String:Any]]
    }
    
    private func convertDataToDictionary(data: Data) -> [String: Any]? {

            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }
}
