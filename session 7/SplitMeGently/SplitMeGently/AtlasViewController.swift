//
//  AtlasViewController.swift
//  SplitMeGently
//
//  Created by Petar Cvijic on 1/19/17.
//  Copyright © 2017 iosBootcamp2017. All rights reserved.
//

import UIKit

class AtlasViewController: UIViewController {

    var item: AtlasItem! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        print("\"\(navigationItem.title!)\" details VC loaded")
    }
    
    deinit {
        print("\"\(navigationItem.title!)\" details VC deallocated")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
  
        detailsTextView.isScrollEnabled = false
        view.layoutIfNeeded()
        detailsTextView.isScrollEnabled = true
    }
    
    private func updateUI() {
        titleName?.text = item?.name ?? "Welcome"
        image?.image = item?.image ?? UIImage(named: "default")
        detailsTextView?.text = item?.details ?? "Please, select an item from the menu on the left"
        navigationItem.title = item?.name ?? "Welcome"
    }
}
