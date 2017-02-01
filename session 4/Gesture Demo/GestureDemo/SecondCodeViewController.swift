//
//  SecondCodeViewController.swift
//  GestureDemo
//
//  Created by Aleksandar Ristanovic on 1/31/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class SecondCodeViewController: UIViewController {

    
    let swipeGesture = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeGesture.direction = .right
        swipeGesture.addTarget(self, action: #selector(self.tapHappened(_:)))
        
        view.addGestureRecognizer(swipeGesture)
    }

    func tapHappened(_ sender: UISwipeGestureRecognizer){
        performSegue(withIdentifier: "GoBackward", sender: self)
    }

}
