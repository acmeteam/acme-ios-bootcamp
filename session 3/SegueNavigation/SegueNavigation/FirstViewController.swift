//
//  ViewController.swift
//  SegueNavigation
//
//  Created by Aleksandar Ristanovic on 1/27/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("------------------------------------")
        print("FirstViewController - View Did Load")
        print("------------------------------------")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Segue With Prepare":
                print("------------------------------------")
                print("Seguing with prepare from FirstViewController->")
                print("------------------------------------")
                if let secondViewControl = segue.destination as? SecondViewController {
                    secondViewControl.cameFromPrepareForSegue()
                }
            case "Segue Through Button Action":
                print("------------------------------------")
                print("Seguing with prepare through button action from FirstViewController->")
                print("------------------------------------")
                if let secondViewControl = segue.destination as? SecondViewController {
                    secondViewControl.cameFromPrepareButtonAction()
                }
            default:
                break
            }
        }
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Segue Through Button Action", sender: nil)
    }
}

