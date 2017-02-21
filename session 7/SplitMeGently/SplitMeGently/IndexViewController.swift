//
//  IndexViewController.swift
//  SplitMeGently
//
//  Created by Petar Cvijic on 1/19/17.
//  Copyright © 2017 iosBootcamp2017. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Index"
        print("Master VC loaded")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        var item: AtlasItem?
        
        switch identifier {
            case "showFerret": item = Animals.Ferret
            case "showPanda": item = Animals.Panda
            case "showTiger": item = Animals.Tiger
            default: item = nil
        }
        
        guard let destinationVC = segue.destination as? AtlasViewController,  item != nil else {
            return
        }
        
        destinationVC.item = item!
    }
}
