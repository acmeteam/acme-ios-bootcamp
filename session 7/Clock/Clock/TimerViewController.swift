//
//  TimerViewController.swift
//  Clock
//
//  Created by Petar Cvijic on 1/26/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, SimpleTimerDelegate {
    @IBOutlet weak var timerDisplay: UILabel!
    private var timer = SimpleTimer(withTick: 1, countingUp: false)
    
    deinit {
        if let title = self.title {
            print("\(title) will be deallocated")
        }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        timer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let title = self.title {
            print("\(title) will appear")
        }
    }

    // MARK:- UIActions
    @IBAction func start(_ sender: UIButton) {
        
        var startTime: TimeInterval?
        
        switch sender.currentTitle! {
            case "5 s": startTime = 5
            case "1 min": startTime = 60
            case "5 min": startTime = 300
            default: break
        }
        
        if let startTime = startTime {
            stop(nil)
            timer.start(with: startTime)
        }
        return
    }
    
    @IBAction func stop(_ sender: UIButton?) {
        timer.stop()
        tabBarItem.badgeValue = nil
    }
    
    // MARK:- Delegate
    func simpleTimerDidUpdated(timer: SimpleTimer, time: TimeInterval) {
        updateTimerDisplay(with: Int(time.rounded()))
        
        if time == 0 {
            tabBarItem.badgeValue = "Done"
        }
    }
    
    // MARK:- Private helpers
    private func convertToHmsString(from seconds : Int) -> String {
        
        let (hours, minutes, seconds) =  (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func updateTimerDisplay(with time: Int) {
        timerDisplay.text = convertToHmsString(from: time)
    }
}
