//
//  FirstPageCodeViewController.swift
//  GestureDemo
//
//  Created by Aleksandar Ristanovic on 1/31/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class FirstCodeViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rotationAngle: UILabel!
    let swipeGesture = UISwipeGestureRecognizer()
    let rotationGesture = UIRotationGestureRecognizer()
    let pinchGesture = UIPinchGestureRecognizer()
    
    var endRotation = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeGesture.direction = .left
        swipeGesture.addTarget(self, action: #selector(swipeHappened(_:)))
        pinchGesture.addTarget(self, action: #selector(pinchHappened(_:)))
        rotationGesture.addTarget(self, action: #selector(rotationHappened(_:)))
        
        view.addGestureRecognizer(swipeGesture)
        view.addGestureRecognizer(rotationGesture)
        view.addGestureRecognizer(pinchGesture)
        
    }
    
    func pinchHappened(_ sender: UIPinchGestureRecognizer) {
        image.transform = image.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
        
    }

    func rotationHappened(_ sender: UIRotationGestureRecognizer) {
        
        endRotation = trunc((Double(sender.rotation) * (180/M_PI) + endRotation)*100)/100
        rotationAngle.text = String(describing: endRotation)
        image.transform = image.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    func swipeHappened(_ sender: UISwipeGestureRecognizer){
        performSegue(withIdentifier: "GoForward", sender: self)
    }
    
}
