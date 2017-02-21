//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Petar Cvijic on 1/26/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    @IBOutlet weak var stopwatchDisplay: UILabel!
    
    private var timer = SimpleTimer(withTick: 0.1, countingUp: true)
    
    
    deinit {
        
        // We have to remove ourselfs from observers' list if we don't exist (or not interested) anymore
        NotificationCenter.default.removeObserver(self)
        
        if let title = self.title {
            print("\(title) will be deallocated")
        }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // At this point, we are "tunning up" to radio station, receiving all the messages with the given name
        NotificationCenter.default.addObserver(self, selector: #selector(simpleTimerUpdated(notification:)), name: Notification.Name.SimpleTimerUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let title = self.title {
            print("\(title) will appear")
        }
    }
    
    // MARK:- UIActions
    @IBAction func toggleAction(_ sender: UIButton) {
        
        let title = sender.currentTitle
        
        switch title! {
            case "Start": timer.start(with: 0)
                          sender.setTitle("Stop", for: UIControlState.normal)
            
            case "Stop": timer.stop()
                         sender.setTitle("Start", for: UIControlState.normal)
            default: break
        }
        return
    }
    
    // MARK:- Notification
    func simpleTimerUpdated (notification: Notification) {
        let userInfo = notification.userInfo

        let currentTime = userInfo?["currentTime"] as? TimeInterval
        let timer =  userInfo?["timer"] as? SimpleTimer
        
        // As notification center broadcast messages from any instance of SimpleTimer,
        // we must check are we interested in the right instance
        
        if let timer = timer, timer === self.timer {
            if let currentTime = currentTime {
                updateStopwatchDisplay(with: currentTime)
            }
        }
    }

    // MARK:- Private helpers
    private func updateStopwatchDisplay(with time: TimeInterval) {
        stopwatchDisplay.text = convertToHmscString(from: time)
    }
    
    private func convertToHmscString(from time: TimeInterval) -> String {
        let fullSeconds = Int(time)
        let (hours, minutes, seconds) =  (fullSeconds / 3600, (fullSeconds % 3600) / 60, (fullSeconds % 3600) % 60)
        let hundredths = Int((time - TimeInterval(fullSeconds))*10)
        
        return String(format: "%02d:%02d:%02d.%d", hours, minutes, seconds, hundredths)
    }
}
