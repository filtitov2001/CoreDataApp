//
//  AppDelegate.swift
//  CoreDataApp
//
//  Created by Felix Titov on 7/29/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

