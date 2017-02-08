//
//  ThirdScreenViewController.swift
//  FirstProjectAssignment
//
//  Created by Aleksandar Ristanovic on 2/6/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class ThirdScreenViewController: UIViewController {

    @IBOutlet weak var smileyFacesButton: UIButton!
    @IBOutlet weak var boxingButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    var firstName = "name"
    var lastName = "<lastname>"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let helloString = "Hello " + firstName + " " + lastName
        helloLabel.text = helloString
        
        smileyFacesButton.layer.borderWidth = 1.0
        smileyFacesButton.layer.borderColor = UIColor.black.cgColor
        boxingButton.layer.borderWidth = 1.0
        boxingButton.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "SegueFromThirdToFourth":
                if let vc = segue.destination as? FourthScreenViewController {
                    vc.firstName = firstName
                }
                print("Segue from third to fourth")
            case "SegueFromThirdToFifth":
                if let vc = segue.destination as? FifthScreenViewController {
                    vc.firstName = firstName
                }
                print("Segue from third to fifth")
            default:
                print("Default third screen")
            }
        }
        
    }

}
