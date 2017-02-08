//
//  FifthScreenViewController.swift
//  FirstProjectAssignment
//
//  Created by Aleksandar Ristanovic on 2/6/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class FifthScreenViewController: UIViewController {
    var firstName = "name"
    let numberString = " number of boxes: "
    var topString = ""
    var boxCount = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topString = firstName + numberString
        updateTopLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateTopLabel() {
        countLabel.text = topString + String(boxCount)
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        
        let xLoc = location.x
        let yLoc = location.y
        
        print("Tap action happened \(xLoc), \(yLoc)")
        
        box(xLoc: location.x - 50, yLoc: location.y - 50)
        
        boxCount += 1
        updateTopLabel()
        
    }
    
    private func box(xLoc: CGFloat, yLoc: CGFloat) {
        let box = BoxView(frame: CGRect(x: xLoc, y: yLoc, width: 100, height: 100))
        box.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteBox(_:))))
        view.addSubview(box)
    }
    
    @objc private func deleteBox(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        boxCount -= 1
        updateTopLabel()
    }
}
