//
//  SimpleClock.swift
//  Clock
//
//  Created by Petar Cvijic on 1/31/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import Foundation

class SimpleClock: NSObject {
    
    // Property must be dynamic in order to enforce dynamic dispatch
    // KVO needs dynamic dispatch for observing properties
    // Also, class must be derrived from NSObject to inherit NSKeyValueObserving protocol
    
    dynamic var currentTime: Date?
    private var timer: Timer?
    
    
    init(with tickInterval: TimeInterval) {
        super.init()
        
        self.timer = Timer.scheduledTimer(timeInterval: tickInterval, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    deinit {
        self.timer?.invalidate()
    }

    func updateTime() {
        currentTime = Date()
    }
}
