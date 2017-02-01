//
//  ThirdStoryboardViewController.swift
//  GestureDemo
//
//  Created by Aleksandar Ristanovic on 1/31/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class ThirdStoryboardViewController: UIViewController {
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    @IBAction func touchedAndHeld(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: view)
        
        xLabel.text = String(describing: round(100*location.x)/100)
        yLabel.text = String(describing: round(100*location.y)/100)
    }

}
