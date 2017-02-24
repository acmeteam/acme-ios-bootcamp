//
//  TextViewController.swift
//  TableView
//
//  Created by User on 1/23/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var text: String? {
        didSet {
            textView?.text = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView?.text = text
    }
}
