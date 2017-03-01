//
//  SampleClass.swift
//  ThreadingExample
//
//  Created by Rasko Gojkovic on 3/1/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation

class SampleClass{
    
    private let lockingQueue = DispatchQueue(label: "myLockingQueue")
    
    var _someResource: String = ""
    var someResource : String{
        get{
            return lockingQueue.sync{_someResource }
        }
        set{
            lockingQueue.sync {_someResource = newValue}
        }
    }
    
}
