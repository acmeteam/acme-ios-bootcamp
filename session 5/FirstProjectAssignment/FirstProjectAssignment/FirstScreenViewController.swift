//
//  FirstScreenViewController.swift
//  FirstProjectAssignment
//
//  Created by Aleksandar Ristanovic on 2/6/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameBox: UITextField!
    @IBOutlet weak var lastNameBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            case "SwipeFromFirstToSecond":
                if let vc = segue.destination as? SecondScreenViewController, let text = firstNameBox.text {
                    vc.firstName = text
                }
            case "LoginFromFirstToThird":
                if let vc = segue.destination as? ThirdScreenViewController, let name = firstNameBox.text, let lastName = lastNameBox.text {
                    vc.firstName = name
                    vc.lastName = lastName
                }
            default:
                print("Default case")
            }
        }
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
