//
//  AppDelegate.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootNavigationController : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = MainViewController.create(storyboard: StoryBoards.main)
        rootNavigationController = UINavigationController(rootViewController: rootViewController)
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

