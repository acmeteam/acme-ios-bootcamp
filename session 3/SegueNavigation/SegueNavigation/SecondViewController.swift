//
//  SecondViewController.swift
//  SegueNavigation
//
//  Created by Aleksandar Ristanovic on 1/27/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var wayWeCame: UILabel!
    
    private var textToDisplay = "Did not do prepare"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("------------------------------------")
        print("SecondViewController - View Did Load")
        print("------------------------------------")
        wayWeCame.text = textToDisplay
    }
    
    func cameFromPrepareForSegue() {
        
        /*
        //code will break if setting up outlet called before viewDidLoad()
        //self.wayWeCame.text = "Did prepare"
        */
        
        textToDisplay = "Did prepare"
    }
    
    func cameFromPrepareButtonAction() {
        textToDisplay = "Did prepare button action"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("     SecondViewController - viewDidLayoutSubviews")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("     SecondViewController - viewWillLayoutSubviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("     SecondViewController - viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("     SecondViewController - viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SecondViewController - viewDidDisappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SecondViewController - viewWillDisappear")
    }

}
