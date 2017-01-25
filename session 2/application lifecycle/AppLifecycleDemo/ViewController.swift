//
//  ViewController.swift
//  AppLifecycleDemo
//
//  Created by Aleksandar Ristanovic on 1/25/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setNotification(_ sender: UIButton) {
        print("---Bundle")
        let mainBundle = Bundle.main
        let fileURL = mainBundle.url(forResource: "test", withExtension: "json")!
        print("fileURL = \(fileURL.absoluteString)")
        
        print("---JSON Data")
        let jsonData = try? Data(contentsOf: fileURL)
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        guard let jsonRes = json as? [String:Any] else {return}
        
        print(jsonRes)
        
        
        
    }

}

