//
//  SimpleViewController.swift
//  NAvigationVC
//
//  Created by Petar Cvijic on 1/18/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {
 
    var welcomeMessage: String? = nil {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    deinit {
        print(title! + " deallocated")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
        
        print( title! + " loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(title! + " appeared")
    }
    
    func setupUI() {
        // Set title to be nicely displayed
        navigationItem.title = title
        view.backgroundColor = getBackgroundColor()
        messageLabel?.text = welcomeMessage
        
        // navigationItem.rightBarButtonItem?.title = getNextVcIdentifier()
    }
    
    @IBAction func goBackFromCode(_ sender: UIButton) {
        guard let popResult =  navigationController?.popViewController(animated: true) else {
            print("I hit the wall, can't go back")
            return
        }
        
        print("Bye, bye " + "\(popResult.title!)")
    }
    
    @IBAction func goNextFromCode(_ sender: UIButton) {
        
        // Does we have the right storyboard identifier?
        guard let nextVcStoryboardIdentifier = getNextVcIdentifier() else {
            print("Can't go further")
            return
        }
        
        // Get the stroyboard where wanted VC is located
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Get the wanted VC itself
        let nextVc = storyboard.instantiateViewController(withIdentifier : nextVcStoryboardIdentifier) as? SimpleViewController
        
        // Does we really have the VC we want?
        if let nextVc = nextVc {
            // Yes, we do. Push it to navigation VC stack
            navigationController?.pushViewController(nextVc, animated: true)
            print("Welcome " + "\(nextVc.title!)" )
        }
    }
    
    @IBAction func goToFirstFromCode(_ sender: UIButton) {
       
        if let firstVC = navigationController?.viewControllers.first {
            _ = navigationController?.popToViewController(firstVC, animated: true)
        }
        
        // This can be also done by calling popToRootVC
        // navigationController?.popToRootViewController(animated: true)
    }
    
    func getNextVcIdentifier() -> String? {
        switch title! {
            case "FirstVC": return "SecondVC"
            case "SecondVC": return "ThirdVC"
            default: return nil
        }
    }
    
    func getBackgroundColor() -> UIColor? {
        switch title! {
            case "FirstVC": return UIColor.white
            case "SecondVC": return  UIColor.lightGray
            case "ThirdVC": return UIColor.yellow
            default: return nil
        }
    }
    
    func updateUI() {
        if let welcomeMessage = welcomeMessage, welcomeMessage != "" {
            messageLabel?.text = "Welcome " + welcomeMessage
        } else {
            messageLabel?.text = "Hey, don't be so shy, tell us your name"
        }
    }
}


