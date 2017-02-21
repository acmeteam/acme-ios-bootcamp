//
//  LoginViewController.swift
//  NAvigationVC
//
//  Created by Petar Cvijic on 1/19/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Are we going to present navigationVC with correct segue ID?
        if let identifier = segue.identifier, let navVC = segue.destination as? UINavigationController, identifier == "showNavigationDemo"{
            
            // Everything is OK, get the top VC from navigation VC ...
            let rootVC = navVC.visibleViewController as! SimpleViewController
            
            // ... and finally perform the preparation
            rootVC.welcomeMessage = userNameTextField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
