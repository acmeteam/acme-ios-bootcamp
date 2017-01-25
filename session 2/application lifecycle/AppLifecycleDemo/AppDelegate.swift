//
//  AppDelegate.swift
//  AppLifecycleDemo
//
//  Created by Aleksandar Ristanovic on 1/25/17.
//  Copyright © 2017 Aleksandar Ristanovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        NSLog("%@", "Application will finish launching with options...")
        print("Application will finish launching with options...")
        print("-Dictionary key:value pairs: ")
        if launchOptions != nil {
            var printValue = ""
            for (key, value) in launchOptions! {
                if value is NSURL {
                    printValue = (value as! NSURL).absoluteString!
                }
                else {
                    printValue = value as! String
                }
                NSLog("key: %@, value: %@", key._rawValue, printValue)
                //print("key = \(key), value = \(value)")
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NSLog("%@", "Application did finish launching with options...")
        print("Application did finish launching with options...")
        print("-Dictionary key:value pairs: ")
        if launchOptions != nil {
            var printValue = ""
            for (key, value) in launchOptions! {
                if value is NSURL {
                    printValue = (value as! NSURL).absoluteString!
                }
                else {
                    printValue = value as! String
                }
                NSLog("key: %@, value: %@", key._rawValue, printValue)
                //print("key = \(key), value = \(value)")
            }

        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        print("Application will resign active...")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("Application did enter background...")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("Application will enter foreground...")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("Application did become active...")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("Application will terminate...")
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("Application did finish launching...")
    }
    
}

