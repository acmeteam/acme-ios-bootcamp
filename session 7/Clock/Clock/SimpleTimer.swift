//
//  SimpleTimer.swift
//  Clock
//
//  Created by Petar Cvijic on 1/26/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import Foundation

protocol SimpleTimerDelegate: class {
    func simpleTimerDidUpdated(timer: SimpleTimer, time: TimeInterval) -> Void
}

class SimpleTimer {
    let tickInterval:TimeInterval
    let countingUp: Bool
    var currentTime: TimeInterval = 0
    weak var delegate: SimpleTimerDelegate?
    
    private let notificationCenter = NotificationCenter.default
    private var timer: Timer?
    
    init(withTick tickInterval: TimeInterval, countingUp: Bool) {
        self.tickInterval = tickInterval
        self.countingUp = countingUp
    }
    
    func start(with timeInSeconds: TimeInterval) {
        if timeInSeconds < 0 {
            return
        }
        
        // Stop the timer
        stop()
        
        // Preload current time
        currentTime = timeInSeconds
        
        // If there is delegate attached, call its appropriate method
        delegate?.simpleTimerDidUpdated(timer: self, time: currentTime)
        
        // Broadcast a message with current timer value inside it
        notificationCenter.post(name: Notification.Name.SimpleTimerUpdated, object: nil, userInfo: ["timer": self, "currentTime": currentTime])
        
        timer = Timer.scheduledTimer(timeInterval: tickInterval, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func stop() {
        // Stop timer
        timer?.invalidate()
    }

    @objc private func tick() {
        if countingUp {
            currentTime += tickInterval
        } else {
            if currentTime > 0 {
                currentTime -= tickInterval

            } else {
                stop()
            }
        }
        
        // If there is delegate attached, call its appropriate method
        delegate?.simpleTimerDidUpdated(timer: self, time: currentTime)
        
        // Broadcast info with current timer value inside it
        notificationCenter.post(name: Notification.Name.SimpleTimerUpdated, object: nil, userInfo: ["timer": self, "currentTime": currentTime])
    }
}
// MARK:- Extensions
extension Notification.Name {
    // MARK: Notification name
     static let SimpleTimerUpdated = Notification.Name("SimpleTimerUpdated")
}
