//
//  ViewController.swift
//  VFL
//
//  Created by Petar Cvijic on 1/30/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let standardDistance = CGFloat(50)
    
    @IBOutlet weak var greatingsLabel: UILabel!
    @IBOutlet weak var tapMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autolayoutStoryboardViews()
    }
    
    func autolayoutStoryboardViews() {
        // Don't forget to add these lines
        greatingsLabel.translatesAutoresizingMaskIntoConstraints = false
        tapMeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a dictionary of all view we want to autolayout
        let views = ["greatings": greatingsLabel as UIView,
                     "tapMeButton": tapMeButton as UIView]

        
        // Vertical constraints
        let vConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-50-[greatings]",
            options: [],
            metrics: nil,
            views: views)
        
        // Horizontal constraints
        let hConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[greatings]-50-[tapMeButton]",
            options: [.alignAllCenterY],
            metrics: nil,
            views: views)
        
        // Apply those constraints
        NSLayoutConstraint.activate(vConstraints + hConstraints)
    }
    
    @IBAction func tapAction(_ sender: UIButton) {
        
        // Example of constraining in code made view
        let inCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        inCodeLabel.text = "Ouch, you hit me!"
        
       
        // Don't forget to add this line
        inCodeLabel.translatesAutoresizingMaskIntoConstraints = false

        
        // Add view to top view
        view.addSubview(inCodeLabel)
        
        // Example of using metrics
        let metrics = ["bottomDistance": standardDistance]
        
        // Create new constratins (lower right corner)
        let newVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[anotherGreating]-bottomDistance-|",
            options: [],
            metrics: metrics,
            views: ["anotherGreating": inCodeLabel])
        
        let newHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[anotherGreating]-bottomDistance-|",
            options: [],
            metrics: metrics,
            views: ["anotherGreating": inCodeLabel])
        
        // Apply those constraints
        NSLayoutConstraint.activate(newVerticalConstraint + newHorizontalConstraint)
    }
}

