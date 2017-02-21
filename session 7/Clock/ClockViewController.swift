//
//  ClockViewController.swift
//  Clock
//
//  Created by Petar Cvijic on 1/26/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController, UITabBarControllerDelegate {
    @IBOutlet weak var timeDisplay: UILabel!

    private let dateFormatter = DateFormatter()
    
    @objc private var clock = SimpleClock(with: 1.0)
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(clock.currentTime))
        
        if let title = self.title {
            print("\(title) will be deallocated")
        }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set ourselfs as tabBarContoller delegate
        tabBarController?.delegate = self
        
        // Setup date formatter
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .none
        
        // Adding KVO for SimpleClock property "currentTime"
        addObserver(self, forKeyPath: #keyPath(clock.currentTime), options: [.new], context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let title = self.title {
            print("\(title) will appear")
        }
    }
    
    // MARK:- KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newTime = change?[.newKey] as? Date {
            timeDisplay?.text = dateFormatter.string(from: newTime)
        }
    }
    
    // MARK:- Delegates
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let title = viewController.title {
            print("Going to \(title)")
        }
    }
}
